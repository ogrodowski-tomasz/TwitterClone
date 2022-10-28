//
//  ExploreController.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 28/10/2022.
//

import UIKit

final class ExploreController: UIViewController {
    
    // MARK: - PROPERTIES
    
    // MARK: - LIFECYCLE

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - HELPERS
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Messages"
    }
}
