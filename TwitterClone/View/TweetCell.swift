//
//  TweetCell.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 30/10/2022.
//

import UIKit

protocol TweetCellDelegate: AnyObject {
    func handleProfileImageTapped(_ cell: TweetCell)
}

class TweetCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "TweetCell"
    
    var tweet: Tweet? {
        didSet {
            configure()
        }
    }
    
    weak var delegate: TweetCellDelegate?
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        let size: CGFloat = 48
        imageView.setDimensions(width: size, height: size)
        imageView.layer.cornerRadius = size / 2
        imageView.backgroundColor = .twitterBlue
        return imageView
    }()
    
    private let infoLabel = UILabel()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "Some Test Caption"
        return label
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .secondaryLabel
        button.setDimensions(width: 20, height: 20)
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .secondaryLabel
        button.setDimensions(width: 20, height: 20)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .secondaryLabel
        button.setDimensions(width: 20, height: 20)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .secondaryLabel
        button.setDimensions(width: 20, height: 20)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        addSubview(stack)
        stack.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        
        infoLabel.font = .systemFont(ofSize: 14)
        infoLabel.text = "Krzysztof Stanowski @k.stanowski"
        
        let actionStack = UIStackView(arrangedSubviews: [
            commentButton,
            retweetButton,
            likeButton,
            shareButton
        ])
        actionStack.axis = .horizontal
        actionStack.spacing = 72
        addSubview(actionStack)
        actionStack.centerX(inView: self)
        actionStack.anchor(bottom: bottomAnchor, paddingBottom: 8)
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
        
        addTapActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Selectors
    
    @objc
    private func handleCommentTapped() {
        print("DEBUG: Comment tapped")
    }
    
    @objc
    private func handleLikeTapped() {
        print("DEBUG: Like tapped")
    }
    
    @objc
    private func handleRetweetTapped() {
        print("DEBUG: Retweet tapped")
    }
    
    @objc
    private func handleShareTapped() {
        print("DEBUG: Share tapped")
    }
    
    @objc
    private func handleProfileImageTapped() {
        delegate?.handleProfileImageTapped(self)
    }

    // MARK: - Helpers
    
    private func addTapActions() {
        // Handle button targets
        commentButton.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        retweetButton.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        
        // Handling tapping on profile image
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        profileImageView.addGestureRecognizer(tap)
        profileImageView.isUserInteractionEnabled = true
        
    }
    
    private func configure() {
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        captionLabel.text = tweet.caption
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        infoLabel.attributedText = viewModel.userInfoText
    }
}
