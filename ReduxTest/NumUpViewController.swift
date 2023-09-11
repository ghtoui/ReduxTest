//
//  NumUpViewController.swift
//  ReduxTest
//
//  Created by toui on 2023/09/11.
//

import UIKit

class NumUpViewController: UIViewController {
    
    
    @IBOutlet weak var numUpLabel: UILabel!
    @IBOutlet weak var num: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        startAnimation()
    }
    
    private func startAnimation() {
        guard let countNum = Int(num.text ?? "100") else {
            return
        }
        
        self.animate(from: 0, to: countNum, duration: 1.5)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    var startTime: CFTimeInterval!
    var fromValue: Int!
    var toValue: Int!
    var duration: TimeInterval!
    
    func animate(from fromValue: Int, to toValue: Int, duration: TimeInterval) {
        numUpLabel.text = "\(fromValue)"
        
        // 開始時間を保存
        self.startTime = CACurrentMediaTime()
        
        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration
        
        // CADisplayLinkの生成
        let link = CADisplayLink(target: self, selector: #selector(updateValue))
        link.add(to: .current, forMode: .default)
    }
    
    @objc func updateValue(link: CADisplayLink) {
        // 開始からの進捗 0.0 〜 1.0くらい
        let dt = (link.timestamp - self.startTime) / duration
        
        // 終了時に最後の値を入れてCADisplayLinkを破棄
        if dt >= 1.0 {
            numUpLabel.text = "\(toValue!)"
            link.invalidate()
            return
        }
        
        // 最初の値に進捗に応じた値を足して現在の値を計算
        let current = Int(Double(toValue - fromValue) * dt) + fromValue
        numUpLabel.text = "\(current)"
    }
    
}
