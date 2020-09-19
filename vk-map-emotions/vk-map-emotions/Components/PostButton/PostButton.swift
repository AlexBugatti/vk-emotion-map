//
//  PostButton.swift
//  vk-map-emotions
//
//  Created by Александр on 18.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class PostButton: NibView {

    var onDidActionTapped: (()->())?
    
    @IBOutlet weak var containerView: UIView! {
        didSet {
            self.containerView.systemRound()
            self.containerView.layer.borderColor = Pallete.textfieldBorderColor.cgColor
            self.containerView.layer.borderWidth = 0.5
        }
    }
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var dropDownImageView: UIImageView! {
        didSet {
            self.dropDownImageView.tintColor = Pallete.textfieldBorderColor
        }
    }
    
    
    class func create(text: String) -> PostButton {
        let button = PostButton()
        button.textLabel.text = text
        
        return button
    }
    
    @IBAction func onDidActionTapped(_ sender: Any) {
        self.onDidActionTapped?()
    }
    
    func active(_ flag: Bool) {
        self.containerView.layer.borderColor = flag ? Pallete.main.cgColor : Pallete.textfieldBorderColor.cgColor
        self.textLabel.textColor = flag ? Pallete.main : Pallete.textfieldBorderColor
        self.dropDownImageView.tintColor = flag ? Pallete.main : Pallete.textfieldBorderColor
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
