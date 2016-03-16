//
//  MonsterGame.swift
//  my-little-monster
//
//  Created by Ryan Collins on 2016-03-16.
//  Copyright © 2016 Ryan Collins. All rights reserved.
//

import Foundation
import UIKit

class MonsterGame {
    
    private var _currentPenalties = 0
    let MAX_PENALTIES = 3
    var timer: NSTimer!
    var monsterHappy = true
    var currentItem: UInt32 = 0
    
    var currentPenalties: Int {
        get {
            return _currentPenalties
        }
    }
    
    init () {        
        startTimer()
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(MonsterGame.changeGameState), userInfo: nil, repeats: true)
    }
    
    @objc func changeGameState() {
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "timeToChangeState", object: nil))
    }
    
    func incrementPenalties() {
        _currentPenalties += 1
    }
    
    func resetGame () {
        _currentPenalties = 0
        startTimer()
    }
    
}