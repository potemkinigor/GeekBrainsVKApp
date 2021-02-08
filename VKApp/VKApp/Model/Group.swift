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
    
    init(name: String, description: String, avatar: UIImage, userIn: Bool) {
        self.name = name
        self.description = description
        self.avatar = avatar
        self.userIn = userIn
    }
}
