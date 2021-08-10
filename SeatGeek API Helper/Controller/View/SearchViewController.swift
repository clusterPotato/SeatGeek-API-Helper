//
//  SearchViewController.swift
//  SeatGeek API Helper
//
//  Created by Gavin Craft on 8/9/21.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate{
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGeneric()
        self.searchBar.delegate = self
    }
    func loadGeneric(){
        EventController.shared.loadEmptyEvents { complete in
            if complete == true{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as? EventCell else { return UITableViewCell()}
        let event = EventController.shared.events[indexPath.row]
        while event.image == nil{
            sleep(0)
        }
        let image = EventController.shared.events[indexPath.row].image
        let df = DateFormatter()
        df.dateFormat = "yyyy-mm-dd'T'hh:mm:ss"
        let dateBack = DateFormatter()
        dateBack.dateStyle = .long
        if let date = df.date(from: event.event.datetime_local){
            cell.setInformation(title: "\(event.event.performers[0].name) at \(event.event.venue.display_location)", timeString: dateBack.string(from: date), locationString: event.event.venue.display_location, image: image, liked: ListOfLikedEvents.shared.contains(id: event.event.id), id: event.event.id)
        }else{
            cell.setInformation(title: "\(event.event.performers[0].name) at \(event.event.venue.display_location)", timeString: "Date undetermined", locationString: event.event.venue.display_location, image: image, liked: ListOfLikedEvents.shared.contains(id: event.event.id), id: event.event.id)
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventController.shared.events.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight/5
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        EventController.shared.searchEvents(text: searchText) { complete in
            if complete{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else{
                print("")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexOfSelected = tableView.indexPathForSelectedRow else { return}
        if segue.identifier == "showDetail"{
            guard let destination = segue.destination as? EventViewController else { return}
            destination.setEvent(EventController.shared.events[indexOfSelected.row])
        }
    }
}
