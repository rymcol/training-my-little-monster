//
//  ViewController.swift
//  my-little-monster
//
//  Created by Ryan Collins on 2016-03-13.
//  Copyright © 2016 Ryan Collins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monster: UIImageView!
    @IBOutlet weak var love: DragableImage!
    @IBOutlet weak var food: DragableImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var monsterImages = [UIImage]()
        
        for i in 1...4 {
            if let img = UIImage(named: "idle\(i)") {
               monsterImages.append(img)
            }
        }
        
        monster.animationImages = monsterImages
        monster.animationDuration = 0.8
        monster.animationRepeatCount = 0
        monster.startAnimating()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

