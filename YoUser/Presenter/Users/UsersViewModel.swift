//
//  UsersViewModel.swift
//  YoUser
//
//  Created by Ruzanna on 24.07.24.
//

import Foundation
import Combine

protocol UsersViewModeling {
    func loadData()
    var dataPublisher: CurrentValueSubject<Result<UserItem>, Never> { get }
    var currentPage: Int { get set }
    func getItemAtIndex(index: Int) -> UserItem
    func searchUsers(searchText: String, isFavorite: Bool)
}

enum Result<T> {
  case loading
  case success([T])
  case error(NetworkError?)
}

class UsersViewModel: UsersViewModeling {
    let repository: DataRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    private var items: [UserItem] = []
    var dataPublisher = CurrentValueSubject<Result<UserItem>, Never>(.loading)
    weak var coordinator: MainCoordinator?
    var currentPage: Int = 1 {
        didSet {
            loadData()
        }
    }
    
    init(repository: DataRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadData() {
        repository.fetchUsers(page: currentPage)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                if case let .failure(error) = completion {
                    dataPublisher.send(.error(error))
                }
            }, receiveValue: { [weak self] data in
                guard let self else { return }
                let freshItems = data.map{ UserItem(user: $0) }
                items.append(contentsOf: freshItems)
                dataPublisher.send(.success(items))
            })
            .store(in: &cancellables)
    }
    
    func searchUsers(searchText: String, isFavorite: Bool) {
        let filterUsers = items.filter { user in
            let matchesText = searchText.isEmpty || user.fullname.lowercased().contains(searchText.lowercased())
            if isFavorite {
                let matchesFavorite = user.isFavorite == isFavorite
                return matchesText && matchesFavorite
            } else {
                return matchesText
            }
        }
        dataPublisher.send(.success(filterUsers))
    }

    func getItemAtIndex(index: Int) -> UserItem {
        items[index]
    }
    
}
