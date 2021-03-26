//
//  Group.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import Foundation
import SwiftUI


class Group {
    var id: Int
    var name: String
    var avatar: UIImage
    var userIn: Bool
    
    init(id: Int, name: String, avatar: UIImage, userIn: Bool) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.userIn = userIn
    }
}
