//
//  Post.swift
//  First-Social
//
//  Created by Neven on 22/09/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _caption: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _postKey: String!
    private var _REF_POST_LIKES: DatabaseReference!
    
    var caption: String {
        if _caption != nil {
            return _caption
        } else {
            return ""
        }
    }
    
    var imageUrl: String! {
        if _imageUrl != nil {
        return _imageUrl
        } else {
            return ""
        }
    }
    
    var likes: Int {
        if _likes != nil {
        return _likes
        } else {
            return -1
        }
    }
    
    var postKey: String {
        if _postKey != nil {
            return _postKey
        } else {
            return ""
        }
    }
    
    init(caption: String, imageUrl: String, likes: Int) {
        self._caption = caption
        self._imageUrl = imageUrl
        self._likes = likes
    }
    
    init(postKey: String, postData: [String: AnyObject]) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
        
        _REF_POST_LIKES = DataService.ds.REF_POSTS.child("\(postKey)/likes")
    }
    
    func adjustLikes(addLike: Bool) {
        if addLike {
            _likes = _likes +  1
        } else {
            _likes = _likes -  1
        }
        _REF_POST_LIKES.setValue(_likes!)
    }
    
}
