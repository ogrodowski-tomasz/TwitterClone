//
//  User.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 29/10/2022.
//

import Firebase
import Foundation

struct User {
    var fullname: String
    let email: String
    var username: String
    var profileImageUrl: URL?
    let uid: String
    var isFollowed = false
    var stats: UserRelationStats?
    var bio: String?
    
    init(uid: String, dictionary: [String : AnyObject]) {
        self.uid = uid
        
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        
        if let bio = dictionary["bio"] as? String {
            self.bio = bio
        }
        
        if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrlString) else { return }
            self.profileImageUrl = url
        }
    }
    
    var isCurrentUser: Bool { Auth.auth().currentUser?.uid == uid }
}

struct UserRelationStats {
    var followers: Int
    var following: Int
}
