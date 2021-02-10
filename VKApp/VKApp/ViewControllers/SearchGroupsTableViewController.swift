//
//  SearchGroupsTableViewController.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import UIKit

class SearchGroupsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "searchGroupsCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchGroupsCell", for: indexPath) as! GroupsTableViewCell
        
        cell.groupsAvatarView.groupAvatar.image = groups[indexPath.row].avatar
        cell.groupNameLabel.text = groups[indexPath.row].name
        cell.numberOfLikes.text = String(groups[indexPath.row].likes)
        cell.likeButton.groupNumber = indexPath.row
        cell.likeButton.isLiked = groups[indexPath.row].liked
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        groups[indexPath.row].userIn = true
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
