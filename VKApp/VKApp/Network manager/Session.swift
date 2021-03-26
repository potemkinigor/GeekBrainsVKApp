//
//  Session.swift
//  VKApp
//
//  Created by User on 21.03.2021.
//

import Foundation
import Alamofire

class Session {
    
    static let shared = Session()
    
    var token: String!
    var userid: Int!
    
    
    private init () {
        
    }
    
    func loadUserGroups() {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let parameters: Parameters = [
            "access_token" : self.token!,
            "extended" : 1,
            "v" : "5.130"
        ]
        
        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseJSON { (response) in
                guard let json = response.value else { return }
                
                print("Список групп пользователя =========================================================================================")
                print(json)
            }

    }
    
    func loadUserFriends() {
        let baseURL = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let parameters: Parameters = [
            "access_token" : self.token!,
            "order" : "random",
            "v" : "5.130"
        ]
        
        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseJSON { (response) in
                guard let json = response.value else { return }
                
                print("Список друзей пользователя =========================================================================================")
                print(json)
            }
    }
    
    func loadUserPhotos() {
        let baseURL = "https://api.vk.com"
        let path = "/method/photos.get"
        
        let parameters: Parameters = [
            "access_token" : self.token!,
            "album_id" : "profile",
            "v" : "5.130"
        ]
        
        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseJSON { (response) in
                guard let json = response.value else { return }
                
                
                print("Список фото пользователя (аватары) =========================================================================================")
                print(json)
            }
    }
    
    func loadFilteredGroups(filterText: String) {
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.search"
        
        let parameters: Parameters = [
            "access_token" : self.token!,
            "q" : filterText,
            "type" : "groups",
            "v" : "5.130"
        ]
        
        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseJSON { (response) in
                guard let json = response.value else { return }
                
                
                print("Список групп по запросу =========================================================================================")
                print(json)
            }
    }
    
    
}
