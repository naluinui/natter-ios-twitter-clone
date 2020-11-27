//
//  PostCell.swift
//  Natter
//
//  Created by Somjintana Korbut on 27/11/2563 BE.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
    }

    func set(post: Post) {
        nameLabel.text = post.owner.name
        timeLabel.text = post.timeString
        captionLabel.text = post.caption
    }

}
