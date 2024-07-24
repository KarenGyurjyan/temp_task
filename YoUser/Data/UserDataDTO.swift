//
//  UserDataDTO.swift
//  YoUser
//
//  Created by Ruzanna on 2.07.24.
//

import Foundation

struct UserDataDTO: Decodable, DomainConvertible {
    typealias DomainModel = UserDataModel
    
    let gender: String
    let name: NameDTO
    let location: LocationDTO
    let email: String
    let phone: String
    let cell: String
    let picture: PictureDTO
    
    func toDomain() -> DomainModel {
        return UserDataModel(gender: gender,
                             name: name.toDomain(),
                             location: location.toDomain(),
                             email: email,
                             phone: phone,
                             cell: cell,
                             picture: picture.toDomain())
    }
    
}

extension UserDataDTO {
    struct NameDTO: Decodable, DomainConvertible {
        typealias DomainModel = UserDataModel.NameModel
        
        let title: String
        let first: String
        let last: String
        
        func toDomain() -> DomainModel {
            return UserDataModel.NameModel(title: title, first: first, last: last)
        }
    }
}

extension UserDataDTO {
    struct LocationDTO: Decodable, DomainConvertible {
        typealias DomainModel = UserDataModel.LocationModel
        
        let street: StreetDTO
        let city: String
        let state: String
        let country: String
//        let postcode: String
        let coordinates: CoordinatesDTO
        
        func toDomain() -> DomainModel {
            return UserDataModel.LocationModel(street: street.toDomain(),
                                               city: city,
                                               state: state,
                                               country: country,
//                                               postcode: postcode,
                                               coordinates: coordinates.toDomain())
        }
        
        struct StreetDTO: Decodable, DomainConvertible {
            typealias DomainModel = UserDataModel.LocationModel.StreetModel
            
            let name: String
            let number: Int
            
            func toDomain() -> DomainModel {
                return UserDataModel.LocationModel.StreetModel(name: name, number: number)
            }
        }
        
        struct CoordinatesDTO: Decodable, DomainConvertible {
            typealias DomainModel = UserDataModel.LocationModel.CoordinatesModel
            
            let latitude: String
            let longitude: String
            
            func toDomain() -> UserDataModel.LocationModel.CoordinatesModel {
                return UserDataModel.LocationModel.CoordinatesModel(latitude: latitude, longitude: longitude)
            }
        }
    }
}

extension UserDataDTO {
    struct PictureDTO: Decodable, DomainConvertible {
        typealias DomainModel = UserDataModel.PictureModel
        
        let large: String
        let medium: String
        let thumbnail: String
        
        func toDomain() -> UserDataModel.PictureModel {
            return UserDataModel.PictureModel(large: large, medium: medium, thumbnail: thumbnail)
        }
    }
}
