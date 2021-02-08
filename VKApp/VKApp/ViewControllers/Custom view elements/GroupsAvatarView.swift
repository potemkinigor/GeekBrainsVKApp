//
//  GroupsAvatarView.swift
//  VKApp
//
//  Created by User on 08.02.2021.
//

import UIKit

@IBDesignable
class GroupsAvatarView: UIView {
    
    @IBOutlet var groupAvatar: UIImageView! {
        didSet {
            self.groupAvatar.layer.cornerRadius = self.cornerRadius
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .gray {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.shadowOpacity = 0.8
        }
    }

}
