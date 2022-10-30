//
//  UploadTweetController.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 29/10/2022.
//

import SDWebImage
import UIKit

class UploadTweetController: UIViewController {
    
    // MARK: - Properties
    
    private let user: User
    
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
    
    private let captionTextView = CaptionTextView() 
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addButtonTargets()
        
    }
    
    // MARK: - Selectors
    
    @objc
    func handleCancel() {
        dismiss(animated: true)
    }
    
    @objc
    func handleUploadTweet() {
        guard let caption = captionTextView.text else { return }
        TweetService.shared.uploadTweet(caption: caption) { error, ref in
            if let error = error {
                print("DEBUG: Failed to upload tweet with error: \(error.localizedDescription)")
                return
            }
            
            self.dismiss(animated: true)
        }
    }
    
    // MARK: - API
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        configureNavigationBar()
        
        view.addSubview(profileImageView)
        view.addSubview(captionTextView)

        profileImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, paddingTop: 16, paddingLeft: 16)
        captionTextView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: profileImageView.rightAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 16, paddingLeft: 12, paddingRight: 16, height: 1200)
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
    }
    
    func addButtonTargets() {
        actionButton.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
}
