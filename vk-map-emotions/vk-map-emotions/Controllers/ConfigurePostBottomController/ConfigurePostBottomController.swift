//
//  ConfigurePostBottomController.swift
//  vk-map-emotions
//
//  Created by Александр on 18.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import BottomPopup

class ConfigurePostBottomController: BottomPopupViewController {

    var didSelectTapped: ((Int)->Void)?
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.text = titleString
        }
    }
    @IBOutlet private weak var tableView: UITableView!
    private var list: [String] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    var titleString: String?
    
    init(title: String, dataSource: [String]) {
        super.init(nibName: nil, bundle: nil)
        self.titleString = title
        self.list = dataSource
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    func setupUI() {
        self.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.view.frame.height)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func onDidDismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Public
    
    func setTitle(_ string: String) {
        self.titleLabel.text = string
    }
    
    func setDataSource(_ source: [String]) {
        self.list = source
    }

}

extension ConfigurePostBottomController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            let item = self.list[indexPath.row]
            cell.textLabel?.text = item
            return cell
        }
        
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectTapped?(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
