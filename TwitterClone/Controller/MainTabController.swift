//
//  MainTabController.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 28/10/2022.
//

import Firebase
import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - PROPERTIES
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(MainTabController.self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .twitterBlue
//        logUserOut()
        authenticateUserAndConfigureUI()
    }
    
    // MARK: - SELECTORS
    
    @objc
    func actionButtonTapped() {
        print(123)
    }
    
    // MARK: - API
    
    func fetchUser() {
        UserService.shared.fetchUser()
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
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("DEBUG: Failed to sign out with error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - HELPERS
    
    func configureUI() {
        tabBar.backgroundColor = .systemBackground
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
        let feedNavVC = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: FeedController())
        
        let exploreNavVC = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: ExploreController())

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
    
}
