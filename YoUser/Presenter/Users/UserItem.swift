//
//  UserItem.swift
//  YoUser
//
//  Created by Ruzanna on 24.07.24.
//

import Foundation

struct UserItem: Hashable {
    let fullname: String
    let gender: String
    let phone: String
    let nationality: String
    let address: String
    let latitude: String
    let longitude: String
    let avatarURL: String
    var isFavorite = false
    
    init(user: UserDataModel) {
        self.fullname = "\(user.name.first) \(user.name.last)"
        self.gender = user.gender
        self.phone = user.phone
        self.nationality = user.location.country // TODO: need to be nationality
        self.address = "\(user.location.street.number) \(user.location.street.name) \(user.location.city) \(user.location.state)"
        self.latitude = user.location.coordinates.latitude
        self.longitude = user.location.coordinates.longitude
        self.avatarURL = user.picture.thumbnail
    }
}
