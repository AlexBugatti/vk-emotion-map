//
//  CategoryCell.swift
//  vk-map-emotions
//
//  Created by Александр on 19.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            self.userImageView.layer.cornerRadius = self.userImageView.frame.height / 2
            self.userImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentTextView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.systemRound()
    }

    func setupUI(post: Post) {
        if let author = post.authorName {
            self.titleLabel.text = author
        }
        if let avatar = post.authorAvatar, let url = URL(string: avatar) {
            self.userImageView.sd_setImage(with: url, completed: nil)
        }
        if let picture = post.picture, let url = URL(string: picture) {
            self.contentImageView.sd_setImage(with: url, completed: nil)
        }
        if let contentText = post.content {
            self.textView.text = contentText
            self.contentTextView.isHidden = false
        } else {
            self.contentTextView.isHidden = true
        }
    }
    
}
