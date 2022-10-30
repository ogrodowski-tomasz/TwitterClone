//
//  UserService.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 29/10/2022.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(uid: String, completion: @escaping (User) -> Void) {        
        // Fetch this only once
        REF_USERS
            .child(uid)
            .observeSingleEvent(of: .value) { snapshot in
                // Snapshot contains value (uid of user) and value (email, username etc...)
                guard let dictionary = snapshot.value as? [String : AnyObject] else { return }

                let user = User(uid: uid, dictionary: dictionary)
                completion(user)
            }
    }
}
