//
//  Store.swift
//  ReduxTest
//
//  Created by toui on 2023/08/23.
//

import Foundation
import ReSwift

let appStore = Store(
    reducer: appReduce,
    state: nil,
    middleware: [])
