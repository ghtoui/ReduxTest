//
//  collectionViewController.swift
//  ReduxTest
//
//  Created by toui on 2023/09/07.
//

import UIKit

class collectionViewController: UIViewController {
    enum Section {
        case main
    }
    
    private var i = 10
    private let sectionHeaderElementKind = "section-header-element-kind"
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleView: UIStackView!
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        //        collectionView.collectionViewLayout = createRowLayout()
        // レイアウトとして返す
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.createRowLayout()
            default:
                return self.createNullLayout()
            }
        }
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        let nib = UINib(nibName: "SecondHeaderCollectionReusableView", bundle: nil)
        collectionView.register(nib, forSupplementaryViewOfKind: "secondHeader", withReuseIdentifier: SecondHeaderCollectionReusableView.identifier)
        
        
        // Do any additional setup after loading the view.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}

extension collectionViewController {
    func createNullLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup(layoutSize: itemSize)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    //    func createRowLayout() -> UICollectionViewLayout {
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
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(129))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        
        let headerSize2 = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30))
        let sectionHeader2 = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize2,
            elementKind: "secondHeader", alignment: .top)
        sectionHeader2.pinToVisibleBounds = true
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
        
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        
        //        section.boundarySupplementaryItems = [sectionHeader, sectionHeader2, sectionFooter]
        section.boundarySupplementaryItems = [sectionHeader, sectionHeader2, sectionFooter]
        
        return section
        
        //        // レイアウトとして返す
        //        let layout = UICollectionViewCompositionalLayout(section: sectionProvider())
        //
        //        return layout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            
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
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<10))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}
