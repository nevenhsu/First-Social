//
//  FancyTextField.swift
//  First-Social
//
//  Created by Neven on 07/09/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit

class FancyTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red: shadowColor, green: shadowColor, blue: shadowColor, alpha: 0.2).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 2
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 4)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 4)
    }

}
