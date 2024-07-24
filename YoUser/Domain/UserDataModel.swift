//
//  UserDataModel.swift
//  YoUser
//
//  Created by Ruzanna on 24.07.24.
//

struct UserDataModel {
    let gender: String
    let name: NameModel
    let location: LocationModel
    let email: String
    let phone: String
    let cell: String
    let picture: PictureModel
}

extension UserDataModel {
    struct NameModel {
        let title: String
        let first: String
        let last: String
    }
}

extension UserDataModel {
    struct LocationModel {
        let street: StreetModel
        let city: String
        let state: String
        let country: String
//        let postcode: String
        let coordinates: CoordinatesModel
        
        struct StreetModel {
            let name: String
            let number: Int
        }
        
        struct CoordinatesModel {
            let latitude: String
            let longitude: String
        }
    }
}

extension UserDataModel {
    struct PictureModel {
        let large: String
        let medium: String
        let thumbnail: String
    }
}

