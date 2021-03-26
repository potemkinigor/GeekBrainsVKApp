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
    
    var id: Int
    var name: String
    var surname: String
    var avatar: UIImage
    
    //MARK: - init

    init(id: Int, name: String, surname: String, avatar: UIImage) {
        self.id = id
        self.name = name
        self.surname = surname
        self.avatar = avatar
    }
    
}


