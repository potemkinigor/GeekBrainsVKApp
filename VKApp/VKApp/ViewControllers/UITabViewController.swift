//
//  UITabViewController.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import UIKit

var users: [User] = []
var groups: [Group] = []

class UITabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

         for index in 0...3 {
            let user = User(name: "Name", surname: "Surname \(index)", dayOfBirth: 30, monthsOfBirth: 10, yearOfBirth: 1990, gender: .male, avatar: UIImage(named: "userAvatar")!)
            users.append(user)
        }
        
        
        for index in 0...10 {
            let group = Group(name: "Group \(index)", description: "Just a simple group as any other", avatar: UIImage(named: "groupsAvatar")!, userIn: false, likes: index * 4, liked: false)
            groups.append(group)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
