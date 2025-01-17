//
//  TestViewController.swift
//  DiffablePractice
//
//  Created by 박다현 on 7/19/24.
//

import UIKit

class SettingViewController: UIViewController {

    enum Section:String,CaseIterable{
        case all = "전체 설정"
        case personal = "개인 설정"
        case etCetra = "기타"
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            configuration.headerMode = .supplementary
            return NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
        }

        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
        return layout
    }

    var dataSource:UICollectionViewDiffableDataSource<Section, Setting>!
    let list = SettingDataManager.shared.fetchList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        
        configureDataSource()
        configureSupplementaryViews()
        updateSnapShot()
        print(list)
    }
    
    private func configureHierarchy(){
        view.addSubview(collectionView)
    }
    
    private func configureLayout(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI(){
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        view.backgroundColor = .white
        title = "설정"
    }
    
    private func configureDataSource(){
        var registeration:UICollectionView.CellRegistration<UICollectionViewListCell, Setting>!
        registeration = UICollectionView.CellRegistration{ cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registeration, for: indexPath, item: itemIdentifier)
            return cell
        })

    }
    
    
    private func updateSnapShot(){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Setting>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list[0], toSection: .all)
        snapshot.appendItems(list[1], toSection: .personal)
        snapshot.appendItems(list[2], toSection: .etCetra)
        dataSource.apply(snapshot)
    }
    
    private func configureSupplementaryViews() {
        // Supplementary registrations
        let headerCellRegistration = makeSectionHeaderRegistration()
        
        dataSource.supplementaryViewProvider = { (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            if elementKind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(using: headerCellRegistration, for: indexPath)
            } else {
                return nil
            }
        }
    }

    private func makeSectionHeaderRegistration() -> UICollectionView.SupplementaryRegistration<UICollectionViewListCell> {
        return UICollectionView.SupplementaryRegistration<UICollectionViewListCell>(elementKind: UICollectionView.elementKindSectionHeader) { (headerView, _, indexPath) in
            let sectionKind = Section.allCases[indexPath.section]
            var content = UIListContentConfiguration.sidebarHeader()
            content.text = sectionKind.rawValue
            content.textProperties.color = .black
            headerView.contentConfiguration = content
        }
    }

}
