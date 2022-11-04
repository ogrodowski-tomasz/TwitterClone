//
//  EditProfileViewModel.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 04/11/2022.
//

import Foundation

enum EditProfileOptions: Int, CaseIterable {
    case fullname
    case username
    case bio
    
    var description: String {
        switch self {
        case .username: return "Username"
        case .fullname: return "Name"
        case .bio: return "Bio"
        }
    }
}

struct EditProfileViewModel {
    
    private let user: User
    let option: EditProfileOptions
    
    init(user: User, option: EditProfileOptions) {
        self.user = user
        self.option = option
    }
    
    var shouldHideTextField: Bool {
        return option == .bio
    }
    
    var shouldHideTextView: Bool {
        return option != .bio
    }
    
    var titleText: String {
        return option.description
    }
    
    var shouldHidePlaceholderLabel: Bool {
        return !(user.bio?.isEmpty ?? true)
    }
    
    var optionValue: String? {
        switch option {
        case .username: return user.username
        case .fullname: return user.fullname
        case .bio: return user.bio
        }
    }
    
    
}
