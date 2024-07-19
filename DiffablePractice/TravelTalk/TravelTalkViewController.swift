//
//  TravelTalkViewController.swift
//  DiffablePractice
//
//  Created by 박다현 on 7/19/24.
//

import UIKit
import SnapKit

final class TravelTalkViewController: UIViewController {

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    var dataSource:UICollectionViewDiffableDataSource<String, ChatRoom>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        
        configureDataSource()
        updateSnapshot()
    }
    
    private func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    private func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "친구 이름을 검색해보세요."
        navigationController?.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var configure = UICollectionLayoutListConfiguration(appearance: .plain)
        configure.showsSeparators = false
        
        let layout = UICollectionViewCompositionalLayout.list(using: configure)
        return layout
    }
    
    private func configureDataSource() {
        var registeration:UICollectionView.CellRegistration<UICollectionViewListCell, ChatRoom>
        registeration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.chatroomName
            content.textProperties.font = .boldSystemFont(ofSize: 16)
            content.textProperties.color = .label
            
            content.secondaryText = itemIdentifier.chatList.last?.message
            content.secondaryTextProperties.color = .secondaryLabel
            content.secondaryTextProperties.font = .systemFont(ofSize: 14)
            
            content.prefersSideBySideTextAndSecondaryText = false
            content.image = UIImage(named: itemIdentifier.chatroomImage.first ?? "") ?? UIImage(systemName: "heart")
            content.imageProperties.maximumSize = CGSize(width: 60, height: 60)
            content.imageProperties.cornerRadius = 30
            cell.contentConfiguration = content
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registeration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func updateSnapshot(){
         var snapshot = NSDiffableDataSourceSnapshot<String, ChatRoom>()
         snapshot.appendSections(["chattingRoom"])
         snapshot.appendItems(mockChatList, toSection:"chattingRoom")
         dataSource.apply(snapshot) //reloadData
    }


}
