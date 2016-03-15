//
//  ViewController.swift
//  my-little-monster
//
//  Created by Ryan Collins on 2016-03-13.
//  Copyright © 2016 Ryan Collins. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monster: Monster!
    @IBOutlet weak var love: DragableImage!
    @IBOutlet weak var food: DragableImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

