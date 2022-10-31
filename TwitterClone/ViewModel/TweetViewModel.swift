//
//  TweetViewModel.swift
//  Pods
//
//  Created by Tomasz Ogrodowski on 30/10/2022.
//

import UIKit

struct TweetViewModel {
    let tweet: Tweet
    let user: User
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }
    
    var usernameText: String {
        return "@\(user.username)"
    }
    
    var profileImageUrl: URL? {
        return user.profileImageUrl
    }
    
    var headerTimestamp: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a ・ MM/dd/yyyy"
        return formatter.string(from: tweet.timestamp)
    }
    
    var retweetsAttrbiutedString: NSAttributedString? {
        return Utilities().attributedText(withValue: tweet.retweetCount, text: "Retweets")
    }
    
    var likesAttrbiutedString: NSAttributedString? {
        return Utilities().attributedText(withValue: tweet.likes, text: "Likes")
    }
    
    var timestamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: tweet.timestamp, to: now) ?? ""
    }
    
    var userInfoText: NSAttributedString {
        // Mutable becuase we are appending to it.
        let title = NSMutableAttributedString(
            string: user.fullname,
            attributes: [
                .font: UIFont.boldSystemFont(ofSize: 14)
            ]
        )
        title.append(
            NSAttributedString(
                string: " @\(user.username)", attributes: [
                    .font: UIFont.systemFont(ofSize: 14),
                    .foregroundColor: UIColor.lightGray
                ]
            )
        )

        title.append(
            NSAttributedString(
                string: " ・ \(timestamp)", attributes: [
                    .font: UIFont.systemFont(ofSize: 14),
                    .foregroundColor: UIColor.lightGray
                ]
            )
        )

        return title
    }
    
    
}
