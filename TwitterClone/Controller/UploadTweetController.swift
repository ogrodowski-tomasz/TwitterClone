//
//  UploadTweetController.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 29/10/2022.
//

import ActiveLabel
import SDWebImage
import UIKit

class UploadTweetController: UIViewController {
    
    // MARK: - Properties
    
    private let user: User
    
    private let config: UploadTweetConfiguration
    private lazy var viewModel = UploadTweetViewModel(config: config)
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        let height: CGFloat = 32
        button.frame = CGRect(x: 0, y: 0, width: height * 2, height: height)
        button.layer.cornerRadius = height / 2
        
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        let size: CGFloat = 48
        imageView.setDimensions(width: size, height: size)
        imageView.layer.cornerRadius = size / 2
        imageView.backgroundColor = .twitterBlue
        return imageView
    }()
    
    private lazy var replyLabel: ActiveLabel = {
        let label = ActiveLabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.mentionColor = .twitterBlue
        label.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        return label
    }()
    
    private let captionTextView = InputTextView()
    
    // MARK: - Lifecycle
    
    init(user: User, config: UploadTweetConfiguration) {
        self.user = user
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addButtonTargets()
        configureMentionHandler()
    }
    
    // MARK: - Selectors
    
    @objc
    func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc
    func handleUploadTweet() {
        guard let caption = captionTextView.text else { return }
        TweetService.shared.uploadTweet(caption: caption, type: config) { error, ref in
            if let error = error {
                print("DEBUG: Failed to upload tweet with error: \(error.localizedDescription)")
                return
            }
            
            if case .reply(let tweet) = self.config {
                NotificationService.shared.uploadNotification(toUser: tweet.user, type: .reply, tweetID: tweet.tweetID)
            }
            
            self.dismiss(animated: true)
        }
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()

        let imageCaptionStack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        imageCaptionStack.axis = .horizontal
        imageCaptionStack.spacing = 12
        imageCaptionStack.alignment = .leading
        imageCaptionStack.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        
        let stack = UIStackView(arrangedSubviews: [replyLabel, imageCaptionStack])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        actionButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        captionTextView.placeholderLabel.text = viewModel.placeholderText
        replyLabel.isHidden = !viewModel.shouldShowReplyLabel
        guard let replyText = viewModel.replyText else { return }
        replyLabel.text = replyText
    }
    
    func addButtonTargets() {
        actionButton.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
    
    func configureMentionHandler() {
        replyLabel.handleMentionTap { mention in
            print("DEBUG: Mentioned user is: \(mention)")
        }
    }
}
