//
//  UserAvatarView.swift
//  VKApp
//
//  Created by User on 08.02.2021.
//

import UIKit

@IBDesignable
class UserAvatarView: UIView {
    
    @IBOutlet var avatarImage: UIImageView! {
        didSet {
            self.avatarImage.layer.cornerRadius = self.cornerRadius
            self.avatarImage.layer.masksToBounds = true
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
            self.layer.shadowOpacity = 0.8
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .gray {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
}
