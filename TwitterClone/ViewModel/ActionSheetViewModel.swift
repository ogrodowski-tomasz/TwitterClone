//
//  ActionSheetViewModel.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 02/11/2022.
//

import Foundation

enum ActionSheetOptions {
    case follow(User)
    case unfollow(User)
    case delete
    case report
}

extension ActionSheetOptions {
    var description: String {
        switch self {
        case .follow(let user):
            return "Follow @\(user.username)"
        case .unfollow(let user):
            return "Unfollow @\(user.username)"
        case .delete:
            return "Delete Tweet"
        case .report:
            return "Report Tweet"
        }
    }
}

struct ActionSheetViewModel {
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var options: [ActionSheetOptions] {
        var results = [ActionSheetOptions]()
        
        if user.isCurrentUser {
            results.append(.delete)
        } else {
            let followOption: ActionSheetOptions = user.isFollowed ? .unfollow(user) : .follow(user)
            results.append(followOption)
        }
        
        results.append(.report)
        
        return results
    }
}
