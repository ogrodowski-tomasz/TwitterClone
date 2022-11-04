//
//  EditProfileHeader.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 04/11/2022.
//

import UIKit

protocol EditProfileHeaderDelegate: AnyObject {
    func didTapChangeProfilePhoto()
}

class EditProfileHeader: UIView {
    
    // MARK: - Properties
        
    private let user: User
    
    weak var delegate: EditProfileHeaderDelegate?
    
    let profileImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        return imageView
    }()
    
    private lazy var changePhotoButton: UIButton = {
       let button = UIButton()
        button.setTitle("Change Profile Photo", for: .normal)
        button.addTarget(self, action: #selector(handleChangeProfilePhoto), for: .touchUpInside)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(frame: .zero)
        
        backgroundColor = .twitterBlue
        
        addSubview(profileImageView)
        profileImageView.center(inView: self, yConstant: -16)
        let imageSize: CGFloat = 100
        profileImageView.setDimensions(
            width: imageSize,
            height: imageSize
        )
        profileImageView.layer.cornerRadius = imageSize / 2
        
        addSubview(changePhotoButton)
        changePhotoButton.centerX(
            inView: self,
            topAnchor: profileImageView.bottomAnchor,
            paddingTop: 8
        )
        profileImageView.sd_setImage(with: user.profileImageUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc
    private func handleChangeProfilePhoto() {
        delegate?.didTapChangeProfilePhoto()
    }
    
    // MARK: - Helpers
}
