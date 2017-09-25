//
//  RoundFancyBtn.swift
//  First-Social
//
//  Created by Neven on 07/09/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit

@IBDesignable
class RoundFancyBtn: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: shadowColor, green: shadowColor, blue: shadowColor, alpha: 0.2).cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 2)
        imageView?.contentMode = .scaleAspectFill
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.size.width / 2
        
    }

}
