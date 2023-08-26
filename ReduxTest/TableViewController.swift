//
//  TableViewController.swift
//  ReduxTest
//
//  Created by toui on 2023/08/26.
//

import UIKit
import ReSwift

class TableViewController: UIViewController {
    
    @IBOutlet weak var visibleButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    private var dataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        appStore.subscribe(self)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        // Stateのアクションを実行
        let action = TableState.tableAction.touchButton
        // actionを渡す
        appStore.dispatch(action)
        
        tableView.dataSource = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TableViewController: StoreSubscriber {
    func newState(state: AppState) {
        dataSource = state.tableState.dataSource
        // TableViewをリロード
        tableView.reloadData()
    }
}

extension TableViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "tableViewCell")
               
               cell.textLabel?.text = dataSource[indexPath.row]
               
               return cell
    }
    
}
