//
//  collectionViewController.swift
//  ReduxTest
//
//  Created by toui on 2023/09/07.
//

import UIKit

class collectionViewController: UIViewController {
    private var isError = false
    
    enum Section: CaseIterable {
        case noHeader
        case header
        case error
    }
    
    @IBAction func errorButtonTapp(_ sender: Any) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        // initial data
        if isError {
            isError = false
            configureCollectionView()
        } else {
            isError = true
            configureErrrorView()
        }
    }
    
    private var i = 10
    private let sectionHeaderElementKind = "section-header-element-kind"
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleView: UIStackView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
    }
    
    private func registerCollectionVIew() {
        let nib = UINib(nibName: "SecondHeaderCollectionReusableView", bundle: nil)
        collectionView.register(nib, forSupplementaryViewOfKind: "secondHeader", withReuseIdentifier: SecondHeaderCollectionReusableView.identifier)
    }
    private func configureCollectionView() {
        configureDataSource()
        registerCollectionVIew()
        
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout { sectionIndex,_ -> NSCollectionLayoutSection? in
            let sectionLayoutKind = Section.allCases[sectionIndex]
            // sectionによって作成するセクションを変更する
            switch sectionLayoutKind {
            case .noHeader:
                return self.createRowLayout()
            case .header:
                return self.createHeaderLayout()
            case .error:
                return self.createErrorLayout()
            }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(Array(0..<10), toSection: .header)
        snapshot.appendItems([11], toSection: .noHeader)
        dataSource.apply(snapshot, animatingDifferences: false)
        collectionView.register(errorCell.nib, forCellWithReuseIdentifier: errorCell.identifier)
    }
    
    private func configureErrrorView() {
        configureDataSource()
        registerCollectionVIew()
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(section: createErrorLayout())
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([20], toSection: .error)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension collectionViewController {
    //    func createRowLayout() -> UICollectionViewLayout {
    func createHeaderLayout() -> NSCollectionLayoutSection {
        // cellのサイズを定義する
        // 比率
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        // itemの指定
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // グループのサイズ
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.3))
        
        // グループに入る項目
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        // セクションの作成
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        // 各item間のスペースを指定できる
        let spacing = CGFloat(1)
        group.interItemSpacing = .fixed(spacing)
        section.interGroupSpacing = spacing
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem( layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        sectionHeader.pinToVisibleBounds = true
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        
        //        section.boundarySupplementaryItems = [sectionHeader, sectionHeader2, sectionFooter]
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        return section
    }
    
    func createRowLayout() -> NSCollectionLayoutSection {
        // cellのサイズを定義する
        // 比率
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        // itemの指定
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // グループのサイズ
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.3))
        
        // グループに入る項目
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        // セクションの作成
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        
        // 各item間のスペースを指定できる
        let spacing = CGFloat(1)
        group.interItemSpacing = .fixed(spacing)
        section.interGroupSpacing = spacing
        
        return section
    }
    
    func createErrorLayout() -> NSCollectionLayoutSection {
        // cellのサイズを定義する
        // 比率
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        // itemの指定
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // グループのサイズ
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(1.5))
        
        // グループに入る項目
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        // セクションの作成
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        // 各item間のスペースを指定できる
        let spacing = CGFloat(1)
        group.interItemSpacing = .fixed(spacing)
        section.interGroupSpacing = spacing
        
        return section
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            
            let section = Section.allCases[indexPath.section]
            print(section)
            switch section {
            case .header:
                // Get a cell of the desired kind.
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TestCollectionViewCell.identifier,
                    for: indexPath) as? TestCollectionViewCell else { fatalError("Cannot create new cell") }
                
                // Populate the cell with our item description.
                cell.titleLabel.text = "ポイント獲得"
                
                cell.setUp(point: identifier)
                
                // backgroung
                cell.backgroundColor = .lightGray
                
                // Return the cell.
                return cell
            case .noHeader:
                // Get a cell of the desired kind.
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: TestCollectionViewCell.identifier,
                    for: indexPath) as? TestCollectionViewCell else { fatalError("Cannot create new cell") }
                
                // Populate the cell with our item description.
                cell.titleLabel.text = "ポイント獲得"
                
                cell.setUp(point: identifier)
                
                // backgroung
                cell.backgroundColor = .lightGray
                
                // Return the cell.
                return cell
                
            case .error :
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: errorCell.identifier,
                    for: indexPath) as? errorCell else { fatalError("Cannot create new cell") }
                
                // Populate the cell with our item description.
                cell.errorLabel.text = "エラーです"
                
                // backgroung
                cell.backgroundColor = .red
                
                // Return the cell.
                return cell
            }
        }
        
        dataSource?.supplementaryViewProvider = {
            (
                collectionView: UICollectionView,
                kind: String,
                indexPath: IndexPath
            ) -> UICollectionReusableView? in
            
            // Get a supplementary view of the desired kind.
            if kind == UICollectionView.elementKindSectionHeader {
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: HeaderCollectionReusableView.identifier,
                    for: indexPath) as? HeaderCollectionReusableView else { fatalError("Cannot create new supplementary") }
                
                // Populate the view with our data.
                header.titleLabel.text = "ポイントが表示されます"
                
                header.backgroundColor = .black
                header.titleLabel.textColor = .white
                
                return header
            }
            
            if kind == "secondHeader" {
                guard let header = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: SecondHeaderCollectionReusableView.identifier,
                    for: indexPath) as? SecondHeaderCollectionReusableView else { fatalError("Cannot create new supplementary") }
                
                // Populate the view with our data.
                header.titleLabel.text = "これが2個目のHeader"
                
                header.backgroundColor = .white
                header.titleLabel.textColor = .black
                
                return header
            }
            
            if kind == UICollectionView.elementKindSectionFooter {
                guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterCollectionReusableView.identifier, for: indexPath) as? FooterCollectionReusableView else {
                    fatalError("Cannnot create new supplementary")
                }
                
                footer.titleLabel.text = "これがフッターです"
                footer.backgroundColor = .black
                footer.titleLabel.textColor = .white
                
                return footer
            }             // Return the view.
            fatalError("failed to get supplementary view")
        }
    }
}
