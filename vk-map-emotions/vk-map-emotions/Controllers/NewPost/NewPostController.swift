//
//  NewPostController.swift
//  vk-map-emotions
//
//  Created by Александр on 18.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class NewPostController: UIViewController, UITextViewDelegate {

    private lazy var tematic: PostButton = {
        var button = PostButton.create(text: "ТЕМАТИКА")
        return button
    }()
    private lazy var mood: PostButton = {
        var button = PostButton.create(text: "НАСТРОЕНИЕ")
        return button
    }()
    private lazy var geo: PostButton = {
        var button = PostButton.create(text: "ГЕОПОЗИЦИЯ")
        return button
    }()
    
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var postButton: UIButton!
    
    
    private var observers = [NSObjectProtocol]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        unregisterKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }

    func setupUI() {
        self.geo.onDidActionTapped = {
            
        }
        self.tematic.onDidActionTapped = {
            self.showTematicController()
        }
        self.mood.onDidActionTapped = {
            self.showMoodController()
        }
        
//        self.stackView.addArrangedSubview(geo)
        self.stackView.addArrangedSubview(tematic)
        self.stackView.addArrangedSubview(mood)
        self.textView.delegate = self
        self.textView.becomeFirstResponder()
    }
    
    // MARK: Actions
    
    @IBAction func onDidDismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDidPostTapped(_ sender: Any) {
        if textView.text.isEmpty == false {
            let alert = UIAlertController.init(title: "Спасибо, пост отправлен на проверку", message: nil, preferredStyle: .alert)
            let action = UIAlertAction.init(title: "ОК", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func showTematicController() {
        let items = Subject.allValues.map({ $0.rawValue })
        let vc = ConfigurePostBottomController(title: "Выберите тематику", dataSource: items)
        vc.didSelectTapped = { index in
            let item = items[index]
            self.tematic.textLabel.text = "\(item)".uppercased()
            self.tematic.active(true)
            vc.dismiss(animated: true, completion: nil)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func showMoodController() {
        let items = Mood.all.map({ "\($0.emoji) \($0.name)" })
        let vc = ConfigurePostBottomController(title: "Выберите настроение",
                                                    dataSource: items)
        vc.didSelectTapped = { index in
            let item = items[index]
            self.mood.textLabel.text = "\(item)".uppercased()
            self.mood.active(true)
            vc.dismiss(animated: true, completion: nil)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.placeholderLabel.isHidden = !textView.text.isEmpty
        let postImage = textView.text.isEmpty ? #imageLiteral(resourceName: "send-sign") : #imageLiteral(resourceName: "send-sign-active")
        self.postButton.setImage(postImage, for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewPostController {
    
    // MARK: - Keyboard Observations
    
    func registerKeyboardNotifications() {
        let center = NotificationCenter.default
        
        let willShowObserver = center.addObserver(with: UIViewController.keyboardWillShow) { payload in
            
            var bottomPadding: CGFloat = 0
            if #available(iOS 11.0, *) {
                bottomPadding = self.view.safeAreaInsets.bottom
            }
            self.bottomConstraint.constant = -(payload.endFrame.height - bottomPadding)
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            }) { (success) in
//                self.scrollView.contentOffset = CGPoint(x: self.scrollView.contentOffset.x,
//                                                        y: self.scrollView.contentOffset.y + 20)
            }
        }
        
        let willHideObserver = center.addObserver(with: UIViewController.keyboardWillHide) { payload in
            self.bottomConstraint.constant = 8
            UIView.animate(withDuration: 0.2, animations: { self.view.layoutIfNeeded() })
        }
        
        observers = [willShowObserver, willHideObserver]
    }
    
    func unregisterKeyboardNotifications() {
        observers.forEach({ NotificationCenter.default.removeObserver($0) })
    }
}
