//
//  FeedVC.swift
//  First-Social
//
//  Created by Neven on 12/09/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signOutTapped(_ sender: UIButton) {
        KeychainWrapper.standard.remove(key: KEY_UID)
        performSegue(withIdentifier: "SigninVC", sender: nil)
    }
    


}
