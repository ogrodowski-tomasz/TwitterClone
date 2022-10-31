//
//  ProfileFilterCell.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 30/10/2022.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "ProfileFilterCell"
    
    var option: ProfileFilterOptions! {
        didSet {
            titleLabel.text = option.description
        }
    }
        
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        label.text = "Test filter"
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ? .boldSystemFont(ofSize: 16) : .systemFont(ofSize: 14)
            titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(titleLabel)
        titleLabel.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
}
