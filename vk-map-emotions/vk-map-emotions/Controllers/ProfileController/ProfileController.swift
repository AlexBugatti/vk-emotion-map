//
//  ProfileController.swift
//  vk-map-emotions
//
//  Created by Александр on 18.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            self.userImageView.layer.cornerRadius = self.userImageView.frame.height / 2
            self.userImageView.layer.masksToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "mister_saxobeat"
        // Do any additional setup after loading the view.
    }
    
    func showNewPostController() {
        let vc = NewPostController.xibViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onDidNewPostTapped(_ sender: Any) {
        self.showNewPostController()
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
