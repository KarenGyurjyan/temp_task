//
//  UserCollectionViewCell.swift
//  YoUser
//
//  Created by Ruzanna on 24.07.24.
//

import UIKit
//import SDWebImage

final class UserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    func configure(_ userItem: UserItem) {
        fullnameLabel.text = userItem.fullname
        infoLabel.text = "\(userItem.gender), \(userItem.phone)\n\(userItem.nationality)\n\(userItem.address)"
    }
}
