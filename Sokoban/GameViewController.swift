//
//  GameViewController.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 30.06.2016.
//  Copyright (c) 2016 CappSoft. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        readLevel()
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }

    func readLevel() {
        
        let jsonPathOptional = NSBundle.mainBundle().pathForResource("level", ofType: "json")
        guard let jsonPath = jsonPathOptional, jsonData = NSData(contentsOfFile: jsonPath) else { return }
        
        do {
            let json =  try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as? NSDictionary
            let levelData = JSONToLevelDataAdapter().adapt(json!)
            let board = LevelDataToBoardAdapter().adapt(levelData!)
            print(board!)
            
        } catch {
            return
        }
    }
}
