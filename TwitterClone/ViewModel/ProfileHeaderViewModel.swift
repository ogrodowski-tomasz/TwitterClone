//
//  ProfileHeaderViewModel.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 30/10/2022.
//

import UIKit

enum ProfileFilterOptions: Int, CaseIterable {
case tweets
case replies
case likes
    
    var description: String {
        switch self {
        case .tweets: return "Tweets"
        case .replies: return "Tweets & Replies"
        case .likes: return "Likes"
        }
    }
}

struct ProfileHeaderViewModel {
    
    private let user: User
    
    init(user: User) {
        self.user = user
        
        usernameText = "@\(user.username)"
    }
    
    let usernameText: String
    
    var followersString: NSAttributedString? {
        return Utilities().attributedText(withValue: user.stats?.followers ?? 0, text: "Followers")
    }
    
    var followingString: NSAttributedString? {
        return Utilities().attributedText(withValue: user.stats?.following ?? 0, text: "Following")
    }
    
    var actionButtonTitle: String {
        // if user is current user then set to "Edit profile"
        // else figure out follow/not-follow
        if user.isCurrentUser {
            return "Edit profile"
        }
        
        if !user.isFollowed && !user.isCurrentUser {
            return "Follow"
        }
        
        if user.isFollowed {
            return "Following"
        }
        
        return ""
    }
    
    fileprivate func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(
            string: "\(value)",
            attributes: [
                .font : UIFont.boldSystemFont(ofSize: 14),
                .foregroundColor : UIColor.label
            ]
        )
        attributedTitle.append(
            NSAttributedString(
                string: " \(text)",
                attributes: [
                    .font : UIFont.systemFont(ofSize: 14),
                    .foregroundColor : UIColor.lightGray
                ]
            )
        )
        return attributedTitle
    }
}
