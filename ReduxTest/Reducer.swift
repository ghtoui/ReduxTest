//
//  Reducer.swift
//  ReduxTest
//
//  Created by toui on 2023/08/23.
//

import Foundation
import ReSwift

struct CounterReducer { }

extension CounterReducer {

    public static func reducer(
        action: ReSwift.Action,
        state: CounterState?
    ) -> CounterState {
        var state = state ?? CounterState()
        
        // actionが無いなら何も変更せず返す
        guard let action = action as? CounterState.counterAction else {
            return state
        }
        switch action {
        case .touchButton:
            state.count += 1
            
        }
        return state
    }
}

let appStore = Store(
    reducer: appReduce,
    state: nil,
    middleware: [])
