//
//  GroupsTableViewCell.swift
//  VKApp
//
//  Created by User on 01.02.2021.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupsAvatarView: GroupsAvatarView!
    @IBOutlet weak var numberOfLikes: UILabel!
    @IBOutlet weak var likeButton: LikeControlButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
