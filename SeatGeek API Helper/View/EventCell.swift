//
//  EventCell.swift
//  SeatGeek API Helper
//
//  Created by Gavin Craft on 8/9/21.
//

import UIKit
class EventCell: UITableViewCell{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    var liked = false
    var id: Int?
    func setInformation(title: String, timeString: String, locationString: String, image: UIImage?, liked: Bool, id: Int){
        titleLabel.text = title
        timeLabel.text = timeString
        locationLabel.text = locationString
        self.id = id
        pictureView.image = image
        if liked{
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.liked = true
        }
    }
    @IBAction func likePressed(_ sender: Any) {
        guard let id = id else { return}
        if self.liked{
            ListOfLikedEvents.shared.removeFromLiked(id: id)
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }else{
            ListOfLikedEvents.shared.addLiked(id: id)
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
}
