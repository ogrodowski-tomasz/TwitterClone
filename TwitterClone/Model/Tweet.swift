//
//  Tweet.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 30/10/2022.
//

import Foundation

struct Tweet {
    let caption: String
    let tweetID: String
//    let uid: String
    let retweetCount: Int
    
    var timestamp: Date!
    var user: User
    var likes: Int
    var didLike = false
    
    init(user: User, tweetID: String, dictionary: [String : Any]) {
        self.tweetID = tweetID
        self.user = user
        
        self.caption = dictionary["caption"] as? String ?? ""
//        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweetCount = dictionary["retweets"] as? Int ?? 0
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}
