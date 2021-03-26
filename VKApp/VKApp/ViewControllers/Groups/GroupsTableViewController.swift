//
//  GroupsTableViewController.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import UIKit



class GroupsTableViewController: UITableViewController {

    var networkManager = Session.shared
    var userGroups: [Group] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadListOfGroupsFromNetwork()
        
        tableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "groupsCell")
    }
    
    //MARK: - Private functions
    
    private func loadListOfGroupsFromNetwork () {
        
        self.networkManager.loadUserGroups { (listOfGroups, imagesDict) in
            listOfGroups.response?.items?.forEach({ (groups) in
                let group = Group(id: groups.id!, name: groups.name!, avatar: imagesDict[groups.id!]!, userIn: (groups.isMember! != 0))
                self.userGroups.append(group)
            })
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    
    }

    @IBAction func searchGroups(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "searchGroups")
        vc.modalPresentationStyle = .fullScreen

        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath) as! GroupsTableViewCell
        
        cell.groupNameLabel.text = userGroups[indexPath.row].name
        cell.groupsAvatarView.groupAvatar.image = userGroups[indexPath.row].avatar
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
}
