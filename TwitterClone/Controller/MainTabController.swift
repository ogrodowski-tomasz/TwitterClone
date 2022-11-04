//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 28/10/2022.
//

import Firebase
import UIKit

enum ActionButtonConfiguration {
    case tweet
    case message
}

class MainTabController: UITabBarController {
    
    // MARK: - PROPERTIES
    
    var user: User? {
        didSet {
            // Ensuring existance of user before showing Feed. each feed is embeded in navCon which are parts of tabCon (feed is the [0]th view)
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            feed.user = user
        }
    }
    
    private var buttonConfig: ActionButtonConfiguration = .tweet
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        return button
    }()
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
        addButtonsTargets()
        authenticateUserAndConfigureUI()
    }
    
    // MARK: - SELECTORS
    
    @objc
    func actionButtonTapped() {
        let controller: UIViewController
        switch buttonConfig {
        case .message:
            controller = SearchController(config: .messages)
        case .tweet:
            guard let user = user else { return }
            controller = UploadTweetController(user: user, config: .tweet)
        }
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true)
    }
    
    // MARK: - API
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        } else {
            configureViewControllers()
            configureUI()
            fetchUser()
        }
    }
    
    
    
    // MARK: - HELPERS
    
    func configureUI() {
        tabBar.backgroundColor = .systemBackground
        
        self.delegate = self
        
        view.addSubview(actionButton)
        let size: CGFloat = 56
        actionButton.anchor(
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.rightAnchor,
            paddingBottom: 64,
            paddingRight: 16,
            width: size,
            height: size
        )
        actionButton.layer.cornerRadius = size / 2
    }
    
    func configureViewControllers() {
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let feedNavVC = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        
        let exploreNavVC = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: SearchController(config: .userSearch))

        let notificationsNavVC = templateNavigationController(image: UIImage(named: "like_unselected"), rootViewController: NotificationsController())

        let converstaionsNavVC = templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: ConversationsController())
        
        viewControllers = [
            feedNavVC,
            exploreNavVC,
            notificationsNavVC,
            converstaionsNavVC
        ]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = image
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
        return navigationController
    }
    
    func addButtonsTargets() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
}

extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = viewControllers?.firstIndex(of: viewController)
        let imageName = index == 3 ? "mail" : "new_tweet"
        actionButton.setImage(UIImage(named: imageName), for: .normal)
        buttonConfig = index == 3 ? .message : .tweet
    }
}
