//
//  State.swift
//  ReduxTest
//
//  Created by toui on 2023/08/23.
//

import Foundation
import ReSwift
import UIKit.UIColor

struct AppState {
    var counterState = CounterState()
}

struct CounterState {
    var count: Int = 0
    var backgroundColor: UIColor = UIColor.white
}
