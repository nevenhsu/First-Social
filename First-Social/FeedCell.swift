//
//  FeedCell.swift
//  First-Social
//
//  Created by Neven on 20/09/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var captionLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var textLbl: UITextView!
    @IBOutlet weak var likesCounter: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
