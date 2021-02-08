//
//  Group.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import Foundation
import SwiftUI


class Group {
    var name: String
    var description: String
    var avatar: UIImage
    var userIn: Bool
    var likes: Int
    var liked: Bool
    
    init(name: String, description: String, avatar: UIImage, userIn: Bool, likes: Int, liked: Bool) {
        self.name = name
        self.description = description
        self.avatar = avatar
        self.userIn = userIn
        self.likes = likes
        self.liked = liked
    }
}
