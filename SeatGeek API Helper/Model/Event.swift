//
//  Event.swift
//  SeatGeek API Helper
//
//  Created by Gavin Craft on 8/9/21.
//

import UIKit
struct Event: Codable{
    let type: String
    let id: Int
    let datetime_local: String
    let venue: Venue
    let performers: [Performer]
}
struct Venue: Codable{
    let name_v2: String
    let city: String
    let state: String
    let display_location: String
}
struct Performer: Codable{
    let name: String
    let image: String
}
struct EventArray: Codable{
    let events: [Event]
}
class EventWithImage{
    let event: Event
    var image: UIImage?
    init(_ event: Event){
        self.event = event
        if let url = URL(string: event.performers[0].image){
            URLSession.shared.dataTask(with: url) { data, _, err in
                if let _ = err{
                    return
                }
                guard let data = data else { return}
                if let image = UIImage(data: data){
                    self.image = image
                }
            }.resume()
        }
    }
}
