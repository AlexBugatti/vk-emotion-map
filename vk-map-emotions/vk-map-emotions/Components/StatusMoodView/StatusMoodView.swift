//
//  StatusMoodView.swift
//  vk-map-emotions
//
//  Created by Александр on 18.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class StatusMoodView: NibView {

    var didTapped: (()->Void)?
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.systemRound()
        }
    }
    @IBOutlet weak var textLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func onDidAction(_ sender: Any) {
        self.didTapped?()
    }
    
    func set(mood: Mood) {
        self.textLabel.text = "\(mood.emoji) \(mood.name) настроение"
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
