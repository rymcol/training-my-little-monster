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
    
    @IBOutlet weak var reviveButton: UIButton!
    
    var gameAudio: GameAudio!
    var monsterGame: MonsterGame!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    
    enum ItemState {
        case enabled
        case disabled
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monsterGame = MonsterGame()
        resetSkulls()
        setDropTargets([love,whip,food])
        changeItemStates([food,love,whip], state: ItemState.disabled)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.changeGameState), name: "timeToChangeState", object: nil)
        
        gameAudio = GameAudio()
        gameAudio.musicPlayer.play()
    }
    
    func setDropTargets (images: [DragableImage]) {
        for image in images {
            image.dropTarget = monster
        }
    }
    
    func itemDroppedOnCharacter (notification: AnyObject) {
        monsterGame.monsterHappy = true
        monsterGame.startTimer()
        
        changeItemStates([food,love,whip], state: ItemState.disabled)
        
        if monsterGame.currentItem == 0 {
            gameAudio.sfxLove.play()
        } else {
            gameAudio.sfxBite.play()
        }
    }
    
    func changeGameState() {
        
        if !monsterGame.monsterHappy {
            
            monsterGame.incrementPenalties()
            
            gameAudio.sfxSkull.play()
            
            if monsterGame.currentPenalties == 1 {
                leftSkull.alpha = OPAQUE
            } else if monsterGame.currentPenalties == 2 {
                middleSkull.alpha = OPAQUE
            } else if monsterGame.currentPenalties >= 3 {
                rightSkull.alpha = OPAQUE
            } else  {
                resetSkulls()
            }
            
            if monsterGame.currentPenalties >= monsterGame.MAX_PENALTIES {
                gameOver()
            }
        }
        
        let rand = arc4random_uniform(3)
        
        if rand == 0 {
            changeItemStates([food, whip], state: ItemState.disabled)
            changeItemStates([love], state: ItemState.enabled)
        } else if rand == 1 {
            changeItemStates([love, whip], state: ItemState.disabled)
            changeItemStates([food], state: ItemState.enabled)
        } else {
            changeItemStates([love, food], state: ItemState.disabled)
            changeItemStates([whip], state: ItemState.enabled)
        }
        
        monsterGame.currentItem = rand
        monsterGame.monsterHappy = false
        
    }
    
    func changeItemStates (items: [DragableImage], state: ItemState) {
        if state == ItemState.enabled {
            for item in items {
                item.alpha = OPAQUE
                item.userInteractionEnabled = true
            }
        } else {
            for item in items {
                item.alpha = DIM_ALPHA
                item.userInteractionEnabled = false
            }
        }
    }
        
    func resetSkulls () {
        leftSkull.alpha = DIM_ALPHA
        middleSkull.alpha = DIM_ALPHA
        rightSkull.alpha = DIM_ALPHA
    }
    
    func gameOver () {
        monsterGame.timer.invalidate()
        monster.playDeathAnimation()
        gameAudio.sfxDead.play()
        
        reviveButton.hidden = false
    }
    
    
    @IBAction func reviveMonster(sender: UIButton) {
        resetSkulls()
        changeItemStates([love,food,whip], state: ItemState.disabled)
        reviveButton.hidden = true
        monster.playResetAnimation()
        monsterGame.resetGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

