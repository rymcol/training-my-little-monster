//
//  GameAudio.swift
//  my-little-monster
//
//  Created by Ryan Collins on 2016-03-16.
//  Copyright © 2016 Ryan Collins. All rights reserved.
//

import Foundation
import AVFoundation

class GameAudio {
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxLove: AVAudioPlayer!
    var sfxDead: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    init() {
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            
            try sfxLove = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            
            try sfxDead = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            sfxSkull.prepareToPlay()
            sfxBite.prepareToPlay()
            sfxLove.prepareToPlay()
            sfxDead.prepareToPlay()
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
}