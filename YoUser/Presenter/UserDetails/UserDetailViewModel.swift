//
//  UserDetailViewModel.swift
//  YoUser
//
//  Created by Ruzanna on 24.07.24.
//

import Foundation
import CoreLocation

protocol UserDetailViewModeling {
    var location: CLLocationCoordinate2D { get }
    var fullname: String { get }
    var gender: String { get }
    var phone: String { get }
    var address: String { get }
}
 
final class UserDetailViewModel: UserDetailViewModeling {
    
    private let userItem: UserItem

    init(userItem: UserItem) {
        self.userItem = userItem
    }
    
    var location: CLLocationCoordinate2D {
        let latitude: CLLocationDegrees = Double(userItem.latitude) ?? 0.0
        let longitude: CLLocationDegrees = Double(userItem.longitude) ?? 0.0
//        let latitude: CLLocationDegrees = 40.7128
//        let longitude: CLLocationDegrees = -74.0060
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var fullname: String { userItem.fullname }
    
    var gender: String { userItem.gender}
    
    var phone: String { userItem.phone }
    
    var address: String { userItem.address }
}
