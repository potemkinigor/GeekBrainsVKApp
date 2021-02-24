//
//  File.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import Foundation
import SwiftUI

enum Gender {
    case male
    case female
}

class User {
    
    //MARK: - person properties
    
    var name: String
    var surname: String
    var avatar: UIImage
    var images: [UIImage]
    
    //MARK: - init

    init(name: String, surname: String, avatar: UIImage, images: [UIImage]) {
        self.name = name
        self.surname = surname
        self.avatar = avatar
        self.images = images
    }
    
}


