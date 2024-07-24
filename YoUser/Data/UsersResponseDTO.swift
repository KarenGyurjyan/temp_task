//
//  UsersResponseDTO.swift
//  YoUser
//
//  Created by Ruzanna on 24.07.24.
//

import Foundation

struct UsersResponseDTO: Decodable {
    let results: [UserDataDTO]
    let info: InfoDTO
}

extension UsersResponseDTO {
    struct InfoDTO: Decodable {
        let results: Int
        let page: Int
    }
}
