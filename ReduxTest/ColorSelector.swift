//
//  Color.swift
//  ReduxTest
//
//  Created by toui on 2023/08/23.
//

import Foundation
import UIKit.UIColor

class ColorSelector {
    public func getColor(counter: Int) -> UIColor {
        let threshold = 10
        var color: UIColor
        
        switch counter % threshold {
        case 1:
            color = UIColor.blue
        case 2:
            color = UIColor.cyan
        case 3:
            color = UIColor.gray
        case 4:
            color = UIColor.green
        case 5:
            color = UIColor.orange
        case 6:
            color = UIColor.purple
        case 7:
            color = UIColor.red
        case 8:
            color = UIColor.darkGray
        case 9:
            color = UIColor.magenta
        default:
            color = UIColor.white
        }
        
        return color
    }
}
