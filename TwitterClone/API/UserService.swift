//
//  UserService.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 29/10/2022.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // Fetch this only once
        REF_USERS
            .child(uid)
            .observeSingleEvent(of: .value) { snapshot in
                // Snapshot contains value (uid of user) and value (email, username etc...)
                guard let dictionary = snapshot.value as? [String : AnyObject] else { return }
                guard let username = dictionary["username"] as? String else { return }
                print("DEBUG: Username is: \(username)")
            }
    }
}
