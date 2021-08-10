//
//  EventController.swift
//  SeatGeek API Helper
//
//  Created by Gavin Craft on 8/9/21.
//

import UIKit
class EventController{
    static let shared = EventController()
    var events: [EventWithImage] = []
    let eventsBaseURL = "https://api.seatgeek.com/2/events"
    
    func loadEmptyEvents(closure: @escaping(Bool)->Void){ //bool will indicate success
        guard let allEventsURL = URL(string: "\(eventsBaseURL)?client_id=\(Strings.clientID)") else {
            return closure(false)}
        URLSession.shared.dataTask(with: URLRequest(url: allEventsURL)) { data, _, error in
            if let error = error{
                print(error)
                return closure(false)
            }
            guard let data = data else {
                return closure(false)}
            do{
                let newEvents = try JSONDecoder().decode(EventArray.self, from: data)
                self.events = newEvents.events.map({EventWithImage($0)})
                closure(true)
            }catch{
                return closure(false)
            }
        }.resume()
    }
    func searchEvents(text: String, closure: @escaping(Bool)->Void){ //bool will indicate success
        guard let allEventsURL = URL(string: "\(eventsBaseURL)/?q=\(text)&client_id=\(Strings.clientID)") else {
            return closure(false)}
        URLSession.shared.dataTask(with: URLRequest(url: allEventsURL)) { data, _, error in
            if let error = error{
                print(error)
                return closure(false)
            }
            guard let data = data else {
                return closure(false)}
            do{
                let newEvents = try JSONDecoder().decode(EventArray.self, from: data)
                self.events = newEvents.events.map({EventWithImage($0)})
                closure(true)
            }catch{
                return closure(false)
            }
        }.resume()
    }
}
