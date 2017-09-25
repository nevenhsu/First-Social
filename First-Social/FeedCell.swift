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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateCell(post: Post, img: UIImage) {
//        do {
//            guard let url = URL(string: post.imageUrl) else {
//                print("JESS: Can't thunbnail url not valid")
//                return
//            }
//            let imageData = try Data(contentsOf: url)
//            thumbnail.image = UIImage(data: imageData)
//        } catch let err {
//            print("JESS: Can't thunbnail url not valid - Error: \(err)")
//        }

        thumbnail.image = img
        
        if post.likes != -1 {
            likesCounter.text = "\(post.likes)"
        } else {
            likesCounter.text = "???"
        }
        
        captionView.text = post.caption
    }

}
