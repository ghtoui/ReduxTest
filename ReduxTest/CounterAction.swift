//
//  Action.swift
//  ReduxTest
//
//  Created by toui on 2023/08/23.
//

import Foundation
import ReSwift

protocol Action { }

extension CounterState {
    enum counterAction: ReSwift.Action {
        case touchButton
    }
}
