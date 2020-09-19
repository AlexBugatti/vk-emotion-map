//
//  FeedCell.swift
//  vk-map-emotions
//
//  Created by Александр on 19.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView! {
        didSet {
            self.userImage.layer.cornerRadius = self.userImage.frame.height / 2
            self.userImage.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var contentTextView: UIView!
    @IBOutlet weak var commtentsCounterLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.containerView.systemRound()
        self.selectionStyle = .none
    }
    
    override func draw(_ rect: CGRect) {
        self.containerView.dropShadow(color: UIColor.black.withAlphaComponent(0.08), opacity: 1, offSet: CGSize(width: 0, height: 2), radius: 2, scale: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(_ post: Post) {
        if let author = post.authorName {
            self.usernameLabel.text = author
        }
        if let avatar = post.authorAvatar, let url = URL(string: avatar) {
            self.userImage.sd_setImage(with: url, completed: nil)
        }
        if let picture = post.picture, let url = URL(string: picture) {
            self.contentImageView.sd_setImage(with: url, completed: nil)
        }
//        if let contentText = post.content {
//            self.textView.text = contentText
//            self.contentTextView.isHidden = false
//        } else {
//            self.contentTextView.isHidden = true
//            self.textView.text = ""
//        }
        if let countComments = post.countComments {
            self.commentLabel.text = "\(countComments) комментариев"
        }
        self.layoutIfNeeded()
    }
    
}
