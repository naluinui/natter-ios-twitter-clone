import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width/2
    }

    func set(post: Post) {
        nameLabel.text = post.owner.name
        timeLabel.text = post.timeString
        captionLabel.text = post.caption
        // TODO: download user image
    }

}
