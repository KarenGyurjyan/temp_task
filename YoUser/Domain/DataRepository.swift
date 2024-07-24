//
//  DataRepository.swift
//  YoUser
//
//  Created by Ruzanna on 24.07.24.
//

import Foundation
import Combine

protocol DataRepositoryProtocol {
    func fetchUsers(page: Int) -> AnyPublisher<[UserDataModel], NetworkError>
}

class DataRepository: DataRepositoryProtocol {
    let apiDataSoure: ApiDataSourceProtocol
    //let localDataSource: LocalDataSourceProtocol // local storage
    private var cancellables = Set<AnyCancellable>()
    
    init(apiDataSoure: ApiDataSourceProtocol) {
        self.apiDataSoure = apiDataSoure
    }
    
    func fetchUsers(page: Int) -> AnyPublisher<[UserDataModel], NetworkError> {
        return apiDataSoure.fetchUsers(request: RequestProvider.init(results: 20, page: page))
            .map { $0.results.toDomain()}
            .eraseToAnyPublisher()
    }
}
