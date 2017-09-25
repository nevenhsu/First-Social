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

class FeedVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImageBtn: RoundFancyBtn!
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
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
            cell.updateCell(post: post)
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImageBtn.setImage(image, for: .normal)
        } else {
            print("JESS: asigning image failed")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func signOutTapped(_ sender: UIButton) {
        KeychainWrapper.standard.remove(key: KEY_UID)
        try! Auth.auth().signOut()
        print("JESS: ID removed from keychain")
        performSegue(withIdentifier: "SigninVC", sender: nil)
    }
    
    @IBAction func addImageBtnPressed(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }
}
