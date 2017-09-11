//
//  ViewController.swift
//  First-Social
//
//  Created by Neven on 05/09/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SigninVC :UIViewController {
    @IBOutlet weak var emailField: FancyTextField!
    
    @IBOutlet weak var passwordField: FancyTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func signinBtnPressed(_ sender: UIButton) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("JESS: Unable to authenticate with Facebook - \(error)")
            } else if (result?.isCancelled)! {
                print("JESS: User Cancelled Facebook authentication")
            } else {
                print("JESS: Successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("JESS: Unable to authenticate with Firebase - \(error)")
            } else {
                print("JESS: Successfully authenticated with Firebase")
            }
        }
    }

    @IBAction func signinTapped(_ sender: UIButton) {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("JESS: Successfully Sign in Firebase")
                } else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error == nil {
                            print("JESS: Successfully authenticated with Firebase")
                        } else {
                            print("JESS: Failed authenticated with Firebase")
                        }
                    })
                }
            })
        }
    }


}

