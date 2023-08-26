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
        
        let colorSelecter = ColorSelector()
        
        // actionが無いなら何も変更せず返す
        guard let action = action as? CounterState.counterAction else {
            return state
        }
        switch action {
        case .touchButton:
            state.count += 1
            state.backgroundColor = colorSelecter.getColor(counter: state.count)
        }
        return state
    }
}

