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
    
    override init (frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation () {
        
        self.image = UIImage(named: "idle1")
        
        self.animationImages = nil
        
        var monsterImages = [UIImage]()
        
        for i in 1...4 {
            if let img = UIImage(named: "idle\(i)") {
                monsterImages.append(img)
            }
        }
        
        self.animationImages = monsterImages
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()
    }
    
    func playDeathAnimation () {
        
        self.image = UIImage(named: "dead5.png")
        
        self.animationImages = nil
        
        var monsterImages = [UIImage]()
        
        for i in 1...5 {
            if let img = UIImage(named: "dead\(i)") {
                monsterImages.append(img)
            }
        }
        
        self.animationImages = monsterImages
        self.animationDuration = 1.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
}