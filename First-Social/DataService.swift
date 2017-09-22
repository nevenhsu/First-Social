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


class DataService {
    
    static let ds = DataService()
    
    private let _REF_POSTS = REF_DB.child("posts")
    private let _REF_USERS = REF_DB.child("users")
    
    var REF_POSTS : DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    
    
    func createFirebaseDBUser(uid: String, userData: [String: String]) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
}

