//
//  ApiDataSource.swift
//  YoUser
//
//  Created by Ruzanna on 24.07.24.
//

import Foundation
import Combine

protocol ApiDataSourceProtocol {
    func fetchUsers(request: NetworkRequest) -> AnyPublisher<UsersResponseDTO, NetworkError>
}

class ApiDataSource: ApiDataSourceProtocol {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchUsers(request: NetworkRequest) -> AnyPublisher<UsersResponseDTO, NetworkError> {
        return networkService.performRequest(request)
    }
}
