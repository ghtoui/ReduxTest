//
//  AppReducer.swift
//  ReduxTest
//
//  Created by toui on 2023/08/23.
//

import Foundation
import ReSwift

func appReduce(
    action: ReSwift.Action,
    state: AppState?
) -> AppState {
    var state = state ?? AppState()
    
    // それぞれのReducerを集約
    state.counterState = CounterReducer.reducer(action: action, state: state.counterState)
    
    state.tableState = TableReducer.reducer(action: action, state: state.tableState)
    
    return state
}
