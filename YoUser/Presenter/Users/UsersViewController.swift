//
//  ViewController.swift
//  YoUser
//
//  Created by Ruzanna on 24.07.24.
//

import UIKit
import Combine

enum SectionType: Hashable {
  case main
}

final class UsersViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: UsersViewModeling = UsersViewModel(repository: DataRepository(apiDataSoure: ApiDataSource(networkService: NetworkService())))
    private var cancellables = Set<AnyCancellable>()
    private lazy var dataSource = makeDataSource()
    private var isFetching = false

    //MARK: - Typealias
    fileprivate typealias DataSource = UICollectionViewDiffableDataSource<SectionType, UserItem>
    fileprivate typealias Snapshot = NSDiffableDataSourceSnapshot<SectionType, UserItem>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
        isFetching = true
        setupCollectionView()
        bind()
    }
    
    private func setupCollectionView() {
        let nib = UINib(nibName: "UserCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier:"UserCollectionViewCell")
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
    }
    
    private func bind() {
        viewModel.dataPublisher
            .sink { [weak self] result in
                guard let self else { return }
                isFetching = false
                switch result {
                case .loading:
                    print("Data Loading")
                case .success(let data):
                    print("data has \(data.count) news")
                    applySnapshot(users: data)
                case .error(let error):
                    print("error is \(error?.localizedDescription)")
                }
            }
            .store(in: &cancellables)
    }
    
    
    @IBAction func segmentedControllChanged(_ sender: UISegmentedControl) {
        viewModel.searchUsers(searchText: searchBar.text ?? "", isFavorite: sender.selectedSegmentIndex == 1)
    }
    
}

extension UsersViewController {
    private func makeDataSource() -> DataSource {
      return UICollectionViewDiffableDataSource<SectionType, UserItem>(collectionView: collectionView, cellProvider: { collectionView, indexPath, userItem in
          guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionViewCell", for: indexPath) as? UserCollectionViewCell else {
            fatalError()
          }
          cell.configure(userItem)
          return cell
       
      })
    }
    
    func applySnapshot(users: [UserItem], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        let section = SectionType.main
        snapshot.appendSections([section])
        snapshot.appendItems(users, toSection: section)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func createMaterialSection(sectionIndex: Int) -> NSCollectionLayoutSection {
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(102))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0)
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(1.0))
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
      let section = NSCollectionLayoutSection(group: group)
      return section
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
      let layout = UICollectionViewCompositionalLayout { [weak self] section, _ in
        return self?.createMaterialSection(sectionIndex: section)
      }
      return layout
    }
}

extension UsersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did select cell")
        let viewModel = UserDetailViewModel(userItem: viewModel.getItemAtIndex(index: indexPath.row))
        let vc = UserDetailsViewController(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension UsersViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        if position > contentHeight - 100 - frameHeight {
            guard !isFetching else { return }
            isFetching = true
            viewModel.currentPage += 1
        }
    }
}

extension UsersViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchUsers(searchText: searchText, isFavorite: segmentedControll.selectedSegmentIndex == 1)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        viewModel.searchUsers(searchText: "", isFavorite: segmentedControll.selectedSegmentIndex == 1)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
}
