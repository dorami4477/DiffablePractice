//
//  ViewController.swift
//  DiffablePractice
//
//  Created by 박다현 on 7/18/24.
//

import UIKit
import SnapKit


final class SettingViewController: UIViewController {
    
    enum Section:CaseIterable{
        case all
        case personal
        case etCetra
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    private func layout() -> UICollectionViewLayout{
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)

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
        view.backgroundColor = .white
        title = "설정"
    }
    


    private func configureDataSource(){
        //CellRegistration<Cell, item>
        var registeration:UICollectionView.CellRegistration<UICollectionViewListCell, Setting>!
        registeration = UICollectionView.CellRegistration{ cell, indexPath, itemIdentifier in
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            backgroundConfig.backgroundColor = .yellow
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeColor = .systemRed
            backgroundConfig.strokeWidth = 1
            cell.backgroundConfiguration = backgroundConfig
            
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

}

