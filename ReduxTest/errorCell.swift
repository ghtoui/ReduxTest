//
//  errorCell.swift
//  ReduxTest
//
//  Created by toui on 2023/09/11.
//

import UIKit

class errorCell: UICollectionViewCell {

    @IBOutlet weak var errorLabel: UILabel!
    static let nib = UINib(nibName: "errorCell", bundle: nil)
    static let identifier = "errorCellIdentifier"
}
