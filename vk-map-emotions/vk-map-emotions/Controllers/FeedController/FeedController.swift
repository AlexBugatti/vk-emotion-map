//
//  FeedController.swift
//  vk-map-emotions
//
//  Created by Александр on 18.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

class FeedController: UIViewController {

    @IBOutlet weak var mapButton: UIButton! {
        didSet {
            self.mapButton.layer.cornerRadius = self.mapButton.frame.height / 2
            self.mapButton.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var tableView: UITableView!
    private var posts: [Post] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
        self.loadPosts()
    }
    
    func setupUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(FeedCell.self)
    }
    
    func loadPosts() {
        API.PostModule.getPosts { (posts) in
            self.posts = posts
        }
    }
    
    func showNewPostController() {
        let vc = NewPostController.xibViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onDidMapTapped(_ sender: Any) {
        let vc = MapController.xibViewController()
        vc.posts = self.posts
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
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

extension FeedController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = self.posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as FeedCell
        cell.setupUI(post)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
    
    
}


