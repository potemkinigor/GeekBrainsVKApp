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
    
    //MARK: - Groups
    
    func loadUserGroups(complition: @escaping (ListOfGroups, [Int : UIImage]) -> Void) {
        
        var listOfGroups: ListOfGroups!
        var listOfAvatars: [Int : UIImage] = [ : ]
        
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let parameters: Parameters = [
            "access_token" : self.token!,
            "extended" : 1,
            "v" : "5.130"
        ]
        
        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseData(completionHandler: { (data) in
                guard let data = data.value else { return }
                do {
                    listOfGroups = try JSONDecoder().decode(ListOfGroups.self, from: data)
                    
                    listOfGroups.response?.items?.forEach({ (group) in
                        guard let url = URL(string: group.photo200!) else {  return }
                        guard let data = try? Data(contentsOf: url) else { return }
                        let image = UIImage(data: data)
                
                        listOfAvatars[group.id!] = image
                    })
                    
                } catch {
                    print(error.localizedDescription)
                }
                
                complition(listOfGroups, listOfAvatars)
            })
    }
    
    func loadFilteredGroups(filterText: String, complition: @escaping (ListOfGroups, [Int : UIImage]) -> Void) {
        
        var listOfGroups: ListOfGroups!
        var listOfAvatars: [Int : UIImage] = [ : ]
        
        let baseURL = "https://api.vk.com"
        let path = "/method/groups.search"
        
        let parameters: Parameters = [
            "access_token" : self.token!,
            "q" : filterText,
            "type" : "groups",
            "v" : "5.130"
        ]
        
        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseData { (data) in
                guard let data = data.value else { return }
                do {
                    listOfGroups = try JSONDecoder().decode(ListOfGroups.self, from: data)
                    
                    listOfGroups.response?.items?.forEach({ (group) in
                        guard let url = URL(string: group.photo200!) else {  return }
                        guard let data = try? Data(contentsOf: url) else { return }
                        let image = UIImage(data: data)
                
                        listOfAvatars[group.id!] = image
                    })
                    
                } catch {
                    print(error.localizedDescription)
                }
                complition(listOfGroups, listOfAvatars)
            }
    }
    
    //MARK: - Friends
    
    func loadUserFriends(completion: @escaping (ListOfFriends, [Int : UIImage]) -> Void) {
        let baseURL = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let parameters: Parameters = [
            "access_token" : self.token!,
            "order" : "random",
            "fields" : "first_name, first_name, photo_200_orig",
            "v" : "5.130"
        ]
        
        var listOfFriends: ListOfFriends!
        var listOfAvatars: [Int : UIImage] = [ : ]
        
        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseData (completionHandler: { (data) in
                guard let data = data.value else { return }
                do {
                    listOfFriends = try JSONDecoder().decode(ListOfFriends.self, from: data)
                    
                    listOfFriends.response?.items?.forEach({ (friend) in
                        let url =  URL(string: friend.photo200_Orig!)
                        let data = try? Data(contentsOf: url!)
                        let image = UIImage(data: data!)
                        
                        listOfAvatars[friend.id!] = image
                    })
                    
                } catch {
                    print(error.localizedDescription)
                }
                
                completion(listOfFriends, listOfAvatars)
            })
    }
    
    func getUsersPhoto (ownerID: Int, completion: @escaping ([UIImage]) -> Void) {
        
        var listOfPhotosArray: [UIImage] = []
        
        let baseURL = "https://api.vk.com"
        let path = "/method/photos.getAll"
        
        let parameters: Parameters = [
            "access_token" : self.token!,
            "owner_id" : ownerID,
            "v" : "5.130"
        ]
        
        AF.request(baseURL + path, method: .get, parameters: parameters)
            .responseData(completionHandler: { (data) in
                guard let data = data.value else { return }
                
                do {
                    let listOfPhotos = try JSONDecoder().decode(ListOfUserPhoto.self, from: data)
                    
                    listOfPhotos.response?.items!.forEach { (photoURL) in
                        let url = URL(string: photoURL.sizes![photoURL.sizes!.count - 1].url!)
                        let data = try? Data(contentsOf: url!)
                        let image = UIImage(data: data!)
                        
                        listOfPhotosArray.append(image!)
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
                
                completion(listOfPhotosArray)
            })
        
        
    }
    
}
