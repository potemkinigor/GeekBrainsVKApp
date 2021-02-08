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
    var dayOfBirth: Int
    var monthsOfBirth: Int
    var yearOfBirth: Int
    var gender: Gender
    var avatar: UIImage
    
    //MARK: - init

    init(name: String, surname: String, dayOfBirth: Int, monthsOfBirth: Int, yearOfBirth: Int, gender: Gender, avatar: UIImage) {
        self.name = name
        self.surname = surname
        self.dayOfBirth = dayOfBirth
        self.monthsOfBirth = monthsOfBirth
        self.yearOfBirth = yearOfBirth
        self.gender = gender
        self.avatar = avatar
    }
    
}


