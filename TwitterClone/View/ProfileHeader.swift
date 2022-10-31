//
//  ProfileHeader.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 30/10/2022.
//

import UIKit

protocol ProfileHeaderDelegate: AnyObject {
    func handleDismissal()
    func handleEditProfileFollow(_ header: ProfileHeader)
}

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ProfileHeader"
    
    weak var delegate: ProfileHeaderDelegate?
    
    var user: User? {
        didSet {
            configure()
        }
    }
    
    private let filterBar = ProfileFilterView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        view.addSubview(backButton)
        backButton.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 42, paddingLeft: 16)
        backButton.setDimensions(width: 30, height: 30)
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "baseline_arrow_back_white_24dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.layer.borderColor = UIColor.systemBackground.cgColor
        imageView.layer.borderWidth = 4
        return imageView
    }()
    
    lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 3
        label.text = "This is a user bio that will span more than one line for test purposes"
        return label
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addTargets()
        filterBar.delegate = self
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 108)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: containerView.bottomAnchor, left: leftAnchor, paddingTop: -24, paddingLeft: 8)
        let size: CGFloat = 80
        profileImageView.setDimensions(width: size, height: size)
        profileImageView.layer.cornerRadius = size / 2
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: containerView.bottomAnchor, right: rightAnchor, paddingTop: 12, paddingRight: 12)
        editProfileFollowButton.setDimensions(width: 100, height: 36)
        editProfileFollowButton.layer.cornerRadius = 36 / 2
        
        let userInfoStack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel, bioLabel])
        userInfoStack.axis = .vertical
        userInfoStack.distribution = .fillProportionally
        userInfoStack.spacing = 4
        
        addSubview(userInfoStack)
        userInfoStack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 12, paddingRight: 12)
        
        let followStack = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        followStack.axis = .horizontal
        followStack.spacing = 8
        followStack.distribution = .fillEqually
        
        addSubview(followStack)
        followStack.anchor(top: userInfoStack.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 12)
        
        addSubview(filterBar)
        filterBar.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
        
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, width: frame.width / 3, height: 2)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Selectors
    
    @objc
    private func handleDismissal() {
        delegate?.handleDismissal()
    }
    
    @objc
    private func handleEditProfileFollow() {
        delegate?.handleEditProfileFollow(self)
    }
    
    @objc
    private func handleFollowersTap() {
        print("DEBUG: Followers tapped")
    }
    
    @objc
    private func handleFollowingTap() {
        print("DEBUG: Following tapped")
    }
    
    // MARK: - Helpers
    
    private func addTargets() {
        backButton.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        editProfileFollowButton.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
        
        let followersTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTap))
        followersLabel.isUserInteractionEnabled = true
        followersLabel.addGestureRecognizer(followersTap)
        
        let followingTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTap))
        followingLabel.isUserInteractionEnabled = true
        followingLabel.addGestureRecognizer(followingTap)
    }
    
    private func configure() {
        guard let user = user else { return }
        
        let viewModel = ProfileHeaderViewModel(user: user)
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        editProfileFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        followingLabel.attributedText = viewModel.followingString
        followersLabel.attributedText = viewModel.followersString
        
        fullnameLabel.text = user.fullname
        usernameLabel.text = viewModel.usernameText
    }
}

// MARK: - ProfileFilterViewDelegate

extension ProfileHeader: ProfileFilterViewDelegate {
    func filterView(_ view: ProfileFilterView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? ProfileFilterCell else {
            return
        }
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
    }
}
