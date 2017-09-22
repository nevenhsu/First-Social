//
//  FeedVC.swift
//  First-Social
//
//  Created by Neven on 12/09/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if let postDic = snap.value as? [String:AnyObject] {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDic)
                        self.posts.append(post)
                    }
                }
                self.tableView.reloadData()
            }
        })
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell {
            let post = posts[indexPath.row]
            
            return cell
        }
        return UITableViewCell()
    }

    @IBAction func signOutTapped(_ sender: UIButton) {
        KeychainWrapper.standard.remove(key: KEY_UID)
        try! Auth.auth().signOut()
        print("JESS: ID removed from keychain")
        performSegue(withIdentifier: "SigninVC", sender: nil)
    }
    


}
