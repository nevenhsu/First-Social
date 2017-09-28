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
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImageBtn: RoundFancyBtn!
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    var imageCache: NSCache<NSString, UIImage> = NSCache()
    var isAddImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                
                var posts = [Post]()
                
                for snap in snapshot {
                    if let postDic = snap.value as? [String:AnyObject] {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDic)
                        posts.append(post)
                    }
                }
                self.posts = posts
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
            
            if let img = imageCache.object(forKey: post.imageUrl as NSString) {
                cell.updateCell(post: post, img: img)
            } else {
                let imgRef = REF_GS.reference(forURL: post.imageUrl)
                
                imgRef.getData(maxSize: 1000 * 1024 * 1024) { (data, err) in
                    if err != nil {
                        print("JESS: Storage get data failed - Error: \(err)")
                    } else {
                        guard let img = UIImage(data: data!) else {
                            return
                        }
                        cell.updateCell(post: post, img: img)
                        self.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                    }
                }
            }
            return cell
        } else {
            return FeedCell()
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImageBtn.setImage(image, for: .normal)
            isAddImage = true
        } else {
            print("JESS: asigning image failed")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func uploadBtnTapped(_ sender: UIButton) {

        guard let caption = captionField.text , !caption.isEmpty  else {
            print("JESS: caption field can't be empty")
            return
        }
        
        guard let img = addImageBtn.currentImage,
            isAddImage,
            let imgData = UIImageJPEGRepresentation(img, 0.2) else {
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let uuid = UUID().uuidString
        
        DataService.ds.REF_POST_IMAGES.child(uuid).putData(imgData, metadata: metadata, completion: { (metadata, err) in
            guard metadata != nil else {
                print("JESS: upload post failed")
                return
            }
            
            let imgUrl = metadata?.downloadURL()?.absoluteString
            
            let data: [String : Any] = [
            "caption": caption,
            "imageUrl": imgUrl ?? "",
            "likes": 0
            ]
            
            DataService.ds.REF_POSTS.childByAutoId().setValue(data)
        })
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
