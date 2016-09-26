//
//  GameViewController.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 30.06.2016.
//  Copyright (c) 2016 CappSoft. All rights reserved.
//

import UIKit
import SpriteKit

protocol GameViewModelDelegate: class {
    func gameViewModel(_:GameViewModel, didWinLevelWithMark mark: Int)
    func gameViewModel(_:GameViewModel, didUpdateMovementCount count: Int)
}

class GameViewController: UIViewController {
    var levelData: LevelData! {
        didSet {
            gameViewModel = GameViewModel(levelData: levelData)
        }
    }
    
    private(set) var gameViewModel: GameViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let skView = self.view as! SKView
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        reloadLevel()
    }
    
    func reloadLevel() {
        let skView = self.view as! SKView
        
        if let levelNode = gameViewModel.initLevel() {
            
            let scene = GameScene(size: CGSizeMake(375,375), boardNode: levelNode)
            scene.scaleMode = .AspectFill
            
            scene.gameDelegate = gameViewModel
            skView.presentScene(scene)
        }
    }
}


