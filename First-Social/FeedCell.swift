//
//  FeedCell.swift
//  First-Social
//
//  Created by Neven on 20/09/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var likesCounter: UILabel!
    @IBOutlet weak var captionView: UITextView!
    
    var REF_USERS_LIKES : DatabaseReference!
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.likeBtnTapped))
        tapGesture.numberOfTapsRequired = 1
        likeImg.addGestureRecognizer(tapGesture)
        likeImg.isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateCell(post: Post, img: UIImage) {
        
        self.post = post
        REF_USERS_LIKES = DataService.ds.REF_CURRENT_USER.child("likes/\(post.postKey)")
        
        thumbnail.image = img
        
        if post.likes != -1 {
            likesCounter.text = "\(post.likes)"
        } else {
            likesCounter.text = "???"
        }
        
        captionView.text = post.caption
        
        REF_USERS_LIKES.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "empty-heart")
            } else {
                self.likeImg.image = UIImage(named: "filled-heart")
            }
        })
    }

    func likeBtnTapped() {
        REF_USERS_LIKES.observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                self.likeImg.image = UIImage(named: "filled-heart")
                self.post.adjustLikes(addLike: true)
                self.REF_USERS_LIKES.setValue(true)
                
            } else {
                self.likeImg.image = UIImage(named: "empty-heart")
                self.post.adjustLikes(addLike: false)
                self.REF_USERS_LIKES.removeValue()
            }

        })
    }
}
