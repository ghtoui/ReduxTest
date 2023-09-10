//
//  TestCollectionReusableView.swift
//  ReduxTest
//
//  Created by toui on 2023/09/09.
//

import UIKit

class TestCollectionViewCell: UICollectionViewCell {

    static let identifier = "collectionViewCellIdentifier"
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setUp(point: Int) {
        pointLabel.text = "+\(point)"
    }
}
