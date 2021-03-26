//
//  FriendsListTableViewController.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import UIKit
import Foundation

enum TypeOfPresentation {
    case showAll
    case showFiltered
}

class FriendsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alphabetFrindsSearch: AlphabetFriendsSearch!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var presentedListOfFriends: [[User]] = [[]]
    var presentedSectionsNames: [Character] = []
    var friends: [User] = []
    
    var delegate: PassFriendInforamtionDelegate?
    
    let networkManager = Session.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //loadListOfFriendsFromNetwork()
        
        print(friends)
        
        prepareListOfFriendsToPresent(typeOfPresentation: .showAll)
        
        tableView.register(UINib(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "friendsReuseIdentifier")
        
        tableView.register(UINib(nibName: "FriendsUITableViewHeaderFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "friendsListHeader")
        
        alphabetFrindsSearch.addTarget(self, action: #selector(changeActiveSections), for: .valueChanged)
   
    }
    
    //MARK: - Private functions
    
    @objc func changeActiveSections () {
        
        var index = 0
        
        for element in presentedSectionsNames {
            if element == self.alphabetFrindsSearch.selectedChar {
                break
            }
            index += 1
        }
        
        if index > presentedSectionsNames.count - 1 {
            index = presentedSectionsNames.count - 1
        }
        
        let indexPath = IndexPath(row: 0, section: index)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func loadListOfFriendsFromNetwork () {
        
        DispatchQueue.global(qos: .background).async {
            self.networkManager.loadUserFriends { [weak self] (friendsList, listOfAvatars) in
                friendsList.response?.items!.forEach({ (friend) in
                    self?.friends.append(User(id: friend.id!, name: friend.firstName!, surname: friend.lastName!, avatar: listOfAvatars[friend.id!]!))
                })
                
                self?.prepareListOfFriendsToPresent(typeOfPresentation: .showAll)
                
            }
        }
    }
    
    private func prepareListOfFriendsToPresent(typeOfPresentation: TypeOfPresentation, searchText: String = "") {
        
        presentedListOfFriends.removeAll()
        presentedSectionsNames.removeAll()
        
        var sectionsFriendsArray: [User] = []
        var nameContainsSearchText: Bool = false
        var surnameContainsSearchText: Bool = false
        
        let sortedFriends = sortFriendsArray(friendsList: friends)
        
        (0..<alphabetArray.count).forEach { charIndex in
            (0..<sortedFriends.count).forEach { friendIndex in
                
                switch typeOfPresentation {
                case .showFiltered:
                    nameContainsSearchText = sortedFriends[friendIndex].name.contains(searchText)
                    surnameContainsSearchText = sortedFriends[friendIndex].surname.contains(searchText)
                case .showAll:
                    nameContainsSearchText = true
                    surnameContainsSearchText = true
                }
                
                let firstCharOfSurname: Character = sortedFriends[friendIndex].surname.first ?? "!"
                
                if firstCharOfSurname == alphabetArray[charIndex] && (nameContainsSearchText || surnameContainsSearchText) {
                    sectionsFriendsArray.append(sortedFriends[friendIndex])
                }
            }
            
            if sectionsFriendsArray.count != 0 {
                presentedListOfFriends.append(sectionsFriendsArray)
                presentedSectionsNames.append(alphabetArray[charIndex])
                sectionsFriendsArray.removeAll()
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func sortFriendsArray (friendsList: [User]) -> [User] {
        let newArray = friends.sorted(by: { $0.surname < $1.surname })
        
        return newArray
    }

}

extension FriendsListViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return presentedListOfFriends.count
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presentedListOfFriends[section].count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsReuseIdentifier", for: indexPath) as! FriendsTableViewCell
        
        cell.userName.text = presentedListOfFriends[indexPath.section][indexPath.row].name + " " + presentedListOfFriends[indexPath.section][indexPath.row].surname
        
        cell.userAvatarView.avatarImage.image = presentedListOfFriends[indexPath.section][indexPath.row].avatar

        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "FriendsCollectionView") as FriendsPhotosViewController
        vc.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.networkManager.getUsersPhoto(ownerID: (self?.presentedListOfFriends[indexPath.section][indexPath.row].id)!) { (images) in
                vc.userImages = images
                vc.loadingIndicator.isHidden = true
                DispatchQueue.main.async {
                    vc.photosCollectionView.reloadData()
                }
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate = vc as? PassFriendInforamtionDelegate
        
        delegate?.passedFriendData(friends[indexPath.row])
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "friendsListHeader") as! FriendsUITableViewHeaderFooterView
        
        let surnameChar = presentedListOfFriends[section][0].surname.first
        
        view.headerTextLabel.text = String(surnameChar!)
        
        view.layer.backgroundColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "friendsListHeader") as! FriendsUITableViewHeaderFooterView
        
        return view.layer.frame.height
    }

}

extension FriendsListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        prepareListOfFriendsToPresent(typeOfPresentation: .showFiltered, searchText: searchText)
               
        self.tableView.reloadData()
    }
    
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        prepareListOfFriendsToPresent(typeOfPresentation: .showAll)
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
    }
}
