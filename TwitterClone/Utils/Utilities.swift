//
//  Utilities.swift
//  TwitterClone
//
//  Created by Tomasz Ogrodowski on 28/10/2022.
//

import UIKit

class Utilities {
    func inputContainerView(withImage image: UIImage?, textField: UITextField) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let imageView = UIImageView()
        imageView.image = image
        view.addSubview(imageView)
        imageView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, paddingLeft: 8, paddingBottom: 8)
        let imageViewSize: CGFloat = 24
        imageView.setDimensions(width: imageViewSize, height: imageViewSize)
        
        view.addSubview(textField)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.anchor(left: imageView.rightAnchor, bottom:  view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom:  view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, height: 0.75)
        
        return view
    }
    
    func textField(withPlaceholder placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return textField
    }
    
    func arrtibutedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        // First part is regular weight and second part is bold.
        let arrtibutedTitle = NSMutableAttributedString(string: firstPart, attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ])
        arrtibutedTitle.append(NSAttributedString(string: secondPart, attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]))
        button.setAttributedTitle(arrtibutedTitle, for: .normal)
        return button
    }
    
    func attributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(
            string: "\(value)",
            attributes: [
                .font : UIFont.boldSystemFont(ofSize: 14),
                .foregroundColor : UIColor.label
            ]
        )
        attributedTitle.append(
            NSAttributedString(
                string: " \(text)",
                attributes: [
                    .font : UIFont.systemFont(ofSize: 14),
                    .foregroundColor : UIColor.lightGray
                ]
            )
        )
        return attributedTitle
    }
}
