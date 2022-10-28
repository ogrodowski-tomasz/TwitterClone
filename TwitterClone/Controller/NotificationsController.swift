//
//  NotificationsController.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 28/10/2022.
//

import UIKit

final class NotificationsController: UIViewController {
    
    // MARK: - PROPERTIES
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - HELPERS
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Explore"
    }
}
