//
//  DataService.swift
//  First-Social
//
//  Created by Neven on 20/09/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import Foundation
import Firebase

let REF_DB = Database.database().reference()
let REF_GS = Storage.storage()

class DataService {
    
    static let ds = DataService()
    
    private let _REF_POSTS = REF_DB.child("posts")
    private let _REF_USERS = REF_DB.child("users")
    private let _REF_POST_IMAGES = REF_GS.reference().child("post-imgs")
    
    var REF_CURRENT_USER: DatabaseReference!
    
    var REF_POSTS : DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    
    var REF_POST_IMAGES : StorageReference {
        return _REF_POST_IMAGES
    }
    
    init() {
        
        if let user = Auth.auth().currentUser {
            REF_CURRENT_USER = REF_USERS.child(user.uid)
        } else {
            REF_CURRENT_USER = REF_USERS.childByAutoId()
        }
    }
    
    func createFirebaseDBUser(uid: String, userData: [String: String]) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}

