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
    private(set) var gameViewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as! SKView
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        if let levelNode = gameViewModel.readLevel() {
            
            let scene = GameScene(size: self.view.bounds.size, boardNode: levelNode)
            scene.scaleMode = .AspectFill
            
            scene.gameDelegate = gameViewModel
            skView.presentScene(scene)
        }
    }
}
