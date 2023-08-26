//
//  CounterViewController.swift
//  ReduxTest
//
//  Created by toui on 2023/08/23.
//

import UIKit
import ReSwift

class CounterViewController: UIViewController, AnyStoreSubscriber {
    
    @IBOutlet var counterLabel: UILabel!
    @IBOutlet var counterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Stateが更新された際に通知を検知できるように登録
        appStore.subscribe(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        appStore.unsubscribe(self)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        // Stateのアクションを実行
        let action = CounterState.counterAction.touchButton
        // actionを渡す
        appStore.dispatch(action)
    }
}

extension CounterViewController: StoreSubscriber {
    
    // ここに値の更新処理を書く
    func newState(state: AppState) {
        // labelTextをボタンを押した回数に
        counterLabel.text = String(state.counterState.count)
        
        // labelTextの背景色をボタンを押した数に応じて変える
        counterLabel.backgroundColor = state.counterState.backgroundColor
    }
}
