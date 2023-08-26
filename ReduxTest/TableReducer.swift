//
//  TableReducer.swift
//  ReduxTest
//
//  Created by toui on 2023/08/26.
//

import Foundation
import ReSwift

struct TableReducer { }

extension TableReducer {
    public static func reducer(
        action: ReSwift.Action,
        state: TableState?
    ) -> TableState {
        var state = state ?? TableState()
        
        guard let action = action as? TableState.tableAction else {
            return state
        }
        
        switch action {
        case .displayButtonTapped:
            state.dataSource = ["aiueo", "kakikukeko", "sasisuseso"]
        case .hideButtonTapped:
            state.dataSource = []
        }
        
        return state
    }
}

