//
//  GroupsTableViewController.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import UIKit

var userGropusCount: Int = 0

var userGroups: [Group] = []

class GroupsTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        
        updateView()
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "groupsCell")
    }

    @IBAction func searchGroups(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "searchGroups")
        vc.modalPresentationStyle = .automatic
        self.navigationController?.pushViewController(vc, animated: true)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return userGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath)
        
        cell.imageView?.image = userGroups[indexPath.row].avatar
        cell.textLabel?.text = userGroups[indexPath.row].name
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for element in groups {
            if userGroups[indexPath.row].name == element.name {
                element.userIn = false
            }
        }

        updateView()
    }
    
    func updateView () {
        userGroups.removeAll()
        
        for element in groups {
            if element.userIn {
                userGroups.append(element)
            }
        }
        
        tableView.reloadData()
    }

}
