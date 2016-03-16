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

    @IBOutlet weak var golemButton: UIButton!
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var ChooseCharacterLabel: UILabel!
    
    @IBOutlet weak var monster: Monster!
    @IBOutlet weak var itemStack: UIStackView!
    @IBOutlet weak var livesStack: UIStackView!
    @IBOutlet weak var livesPanel: UIImageView!
    @IBOutlet weak var love: DragableImage!
    @IBOutlet weak var food: DragableImage!
    @IBOutlet weak var whip: DragableImage!
    
    @IBOutlet weak var leftSkull: UIImageView!
    @IBOutlet weak var middleSkull: UIImageView!
    @IBOutlet weak var rightSkull: UIImageView!
    
    @IBOutlet weak var reviveButton: UIButton!
    
    var monsterGame: MonsterGame!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    
    enum ItemState {
        case enabled
        case disabled
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func choseGolem(sender: UIButton) {
        monster.image = UIImage(named: "golem-idle1.png")
        monster.monsterName = "golem"
        monster.deadImageCount = 5
        monster.playIdleAnimation()
        startGame()
    }
    
    
    @IBAction func choseSnail(sender: UIButton) {
        monster.image = UIImage(named: "snail-idle1.png")
        monster.monsterName = "snail"
        monster.deadImageCount = 3
        monster.playIdleAnimation()
        startGame()
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
            monsterGame.gameAudio.sfxLove.play()
        } else {
            monsterGame.gameAudio.sfxBite.play()
        }
    }
    
    func changeGameState() {
        
        if !monsterGame.monsterHappy {
            
            monsterGame.addPenalty()
            
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
        
        monsterGame.setCurrentItem(rand)
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
        monsterGame.gameAudio.sfxDead.play()
        reviveButton.hidden = false
    }
    
    func startGame() {
        
        ChooseCharacterLabel.hidden = true
        golemButton.hidden = true
        snailButton.hidden = true
        
        livesPanel.hidden = false
        livesStack.hidden = false
        itemStack.hidden = false
        monster.hidden = false
        
        monsterGame = MonsterGame()
        resetSkulls()
        setDropTargets([love,whip,food])
        changeItemStates([food,love,whip], state: ItemState.disabled)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.changeGameState), name: "timeToChangeState", object: nil)
    }
    
    
    @IBAction func reviveMonster(sender: UIButton) {
        resetSkulls()
        changeItemStates([love,food,whip], state: ItemState.disabled)
        reviveButton.hidden = true
        monster.playResetAnimation()
        monsterGame.resetMonster()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

