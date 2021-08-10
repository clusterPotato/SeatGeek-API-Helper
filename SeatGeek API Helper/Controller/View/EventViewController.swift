//
//  EventViewController.swift
//  SeatGeek API Helper
//
//  Created by Gavin Craft on 8/9/21.
//

import UIKit
class EventViewController: UIViewController{
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    var eventImageCombo: EventWithImage?
    var liked = false
    
    func setEvent(_ event: EventWithImage){
        self.eventImageCombo = event
    }
    @IBAction func likePressed(_ sender: Any) {
        guard let event = eventImageCombo else { return}
        liked = ListOfLikedEvents.shared.contains(id: event.event.id)
        if self.liked{
            ListOfLikedEvents.shared.removeFromLiked(id: event.event.id)
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }else{
            ListOfLikedEvents.shared.addLiked(id: event.event.id)
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let eventImageCombo = eventImageCombo else { return}
        let df = DateFormatter()
        df.dateFormat = "yyyy-mm-dd'T'hh:mm:ss"
        let dateBack = DateFormatter()
        dateBack.dateStyle = .long
        guard let date = df.date(from: eventImageCombo.event.datetime_local)else{
            return
        }
        self.timeLabel.text = dateBack.string(from: date)
        self.placeLabel.text = eventImageCombo.event.venue.display_location
        self.titleLabel.text = "\(eventImageCombo.event.performers[0].name) at \(eventImageCombo.event.venue.display_location)"
        self.eventImageView.image = eventImageCombo.image
        liked = ListOfLikedEvents.shared.contains(id: eventImageCombo.event.id)
        if liked{
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
}
