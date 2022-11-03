//
//  NotificationViewModel.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 02/11/2022.
//

import UIKit

struct NotificationViewModel {
    
    // MARK: - Stored properties
    
    private let notification: Notification
    private let type: NotificationType
    private let user: User
    
    // MARK: - Init
    
    init(notification: Notification) {
        self.notification = notification
        self.type = notification.type
        self.user = notification.user
    }
    
    // MARK: - Computed properties
    
    var notificationMessage: String {
        switch type {
        case .follow:
            return " started following You!"
        case .like:
            return " liked your tweet"
        case .reply:
            return " replyed to your tweet"
        case .retweet:
            return " retweeted your tweet"
        case .mention:
            return " mentioned you in a tweet"
        }
    }
    
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: notification.timestamp, to: now) ?? ""
    }
    
    var profileImageUrl: URL? {
        return user.profileImageUrl
    }
    
    var notificationText: NSAttributedString? {
        guard let timestamp = timestampString else { return nil }
        let attributedText = NSMutableAttributedString(
            string: user.username,
            attributes: [
                .font : UIFont.boldSystemFont(ofSize: 12)
            ]
        )
        attributedText.append(NSAttributedString(
            string: notificationMessage,
            attributes: [
                .font : UIFont.systemFont(ofSize: 12)
            ]
        ))
        attributedText.append(NSAttributedString(
            string: " \(timestamp)",
            attributes: [
                .font : UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.lightGray
            ]
        ))
        
        return attributedText
    }
    
    var shouldHideFollowButton: Bool {
        return type != .follow
    }
    
    var followButtonText: String {
        return user.isFollowed ? "Following" : "Follow"
    }
    
    // MARK: - Methods
}
