//
//  ViewController.swift
//  my-little-monster
//
//  Created by Ryan Collins on 2016-03-13.
//  Copyright © 2016 Ryan Collins. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var monster: Monster!
    @IBOutlet weak var love: DragableImage!
    @IBOutlet weak var food: DragableImage!
    @IBOutlet weak var whip: DragableImage!
    
    @IBOutlet weak var leftSkull: UIImageView!
    @IBOutlet weak var middleSkull: UIImageView!
    @IBOutlet weak var rightSkull: UIImageView!
    
    var gameAudio: GameAudio!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    var currentPenalties = 0
    var timer: NSTimer!
    var monsterHappy = false
    var currentItem: UInt32 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        food.dropTarget = monster; love.dropTarget = monster;
        
        setAlpha(leftSkull, alpha: DIM_ALPHA)
        setAlpha(middleSkull, alpha: DIM_ALPHA)
        setAlpha(rightSkull, alpha: DIM_ALPHA)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        gameAudio = GameAudio()
        gameAudio.musicPlayer.play()
        startTimer()
    }
    
    func itemDroppedOnCharacter (notification: AnyObject) {
        monsterHappy = true
        startTimer()
        
        food.alpha = DIM_ALPHA
        love.alpha = DIM_ALPHA
        
        food.userInteractionEnabled = false
        love.userInteractionEnabled = false
        
        if currentItem == 0 {
            gameAudio.sfxLove.play()
        } else {
            gameAudio.sfxBite.play()
        }
    }
    
    func setAlpha (image: UIImageView, alpha: CGFloat) {
        image.alpha = alpha
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState() {
        
        if !monsterHappy {
            
            currentPenalties += 1; gameAudio.sfxSkull.play();
            
            if currentPenalties == 1 {
                setAlpha(leftSkull, alpha: OPAQUE)
            } else if currentPenalties == 2 {
                setAlpha(middleSkull, alpha: OPAQUE)
            } else if currentPenalties >= 3 {
                setAlpha(rightSkull, alpha: OPAQUE)
            } else  {
                setAlpha(leftSkull, alpha: DIM_ALPHA)
                setAlpha(middleSkull, alpha: DIM_ALPHA)
                setAlpha(rightSkull, alpha: DIM_ALPHA)
            }
            
            if currentPenalties >= MAX_PENALTIES {
                gameOver()
            }
        }
        
        let rand = arc4random_uniform(2)
        
        if rand == 0 {
            food.alpha = DIM_ALPHA
            food.userInteractionEnabled = false
            
            love.alpha = OPAQUE
            love.userInteractionEnabled = true
        } else {
            love.alpha = DIM_ALPHA
            love.userInteractionEnabled = false
            
            food.alpha = OPAQUE
            food.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false
        
        
    }
    
    func gameOver () {
        timer.invalidate()
        monster.playDeathAnimation()
        gameAudio.sfxDead.play()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

