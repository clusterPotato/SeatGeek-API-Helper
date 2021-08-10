//
//  ListOfLiked.swift
//  SeatGeek API Helper
//
//  Created by Gavin Craft on 8/9/21.
//

import Foundation
class ListOfLikedEvents{
    static let shared = ListOfLikedEvents()
    var liked: [Int] = []
    
    init(){
        loadFromPersistenceStore()
        print(liked)
    }
    
    func addLiked(id: Int){
        liked.append(id)
        saveToPersistenceStore()
    }
    func contains(id: Int)->Bool{
        liked.contains(id)
    }
    func removeFromLiked(id: Int){
        guard let index = liked.firstIndex(of: id) else { return}
        liked.remove(at: index)
        saveToPersistenceStore()
    }
    
    //MARK: -  persistence
        func createPersistenceStore() -> URL {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let fileURL = url[0].appendingPathComponent("tasks.json")
            return fileURL
        }
        func saveToPersistenceStore(){
            do{
                let data = try JSONEncoder().encode(liked)
                try data.write(to: createPersistenceStore())
            }catch{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
        func loadFromPersistenceStore(){
            do{
                let data = try Data(contentsOf: createPersistenceStore())
                liked = try JSONDecoder().decode([Int].self, from: data)
            }catch{
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
}
