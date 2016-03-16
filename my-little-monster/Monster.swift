//
//  Monster.swift
//  my-little-monster
//
//  Created by Ryan Collins on 2016-03-15.
//  Copyright © 2016 Ryan Collins. All rights reserved.
//

import Foundation
import UIKit

class Monster: UIImageView {
    
    var monsterName = "golem"
    var idleImageCount = 4
    var deadImageCount = 5
    
    override init (frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func playIdleAnimation () {
        
        self.image = UIImage(named: "\(monsterName)-idle1")
        
        self.animationImages = nil
        
        var monsterImages = [UIImage]()
        
        for i in 1...idleImageCount {
            if let img = UIImage(named: "\(monsterName)-idle\(i)") {
                monsterImages.append(img)
            }
        }
        
        self.animationImages = monsterImages
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation () {
        
        self.image = UIImage(named: "\(monsterName)-dead5.png")
        
        self.animationImages = nil
        
        var monsterImages = [UIImage]()
        
        for i in 1...deadImageCount {
            if let img = UIImage(named: "\(monsterName)-dead\(i)") {
                monsterImages.append(img)
            }
        }
        
        self.animationImages = monsterImages
        self.animationDuration = 1.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
    func playResetAnimation() {
        self.image = UIImage(named: "\(monsterName)-idle1.png")
        
        self.animationImages = nil
        
        var monsterImages = [UIImage]()
        
        for i in (1...deadImageCount).reverse() {
            if let img = UIImage(named: "\(monsterName)-dead\(i)") {
                monsterImages.append(img)
            }
        }
        
        self.animationImages = monsterImages
        self.animationDuration = 1.8
        self.animationRepeatCount = 1
        self.startAnimating()
        
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector(Monster.playIdleAnimation), userInfo: nil, repeats: false)
        
    }
    
}