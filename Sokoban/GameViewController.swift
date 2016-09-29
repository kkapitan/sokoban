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
    
    @IBOutlet weak var scrollView: UIScrollView!
    weak var skView: SKView?
    
    private(set) var gameViewModel: GameViewModel!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
        reloadLevel()
    }
    
    func reloadLevel() {
        if let levelNode = gameViewModel.initLevel() {
            skView?.removeFromSuperview()
            
            let size = levelNode.nodeSize
            
            let width = max(size.width, scrollView.frame.size.width)
            let height = max(size.height, scrollView.frame.size.height)
            
            let newSize = CGSizeMake(width, height)
            
            let view = SKView(frame: CGRect(origin: CGPointZero, size: newSize))
            
            scrollView.addSubview(view)
            scrollView.contentSize = newSize
            
            let scene = GameScene(size: newSize, boardNode: levelNode)
            scene.scaleMode = .AspectFit
            
            scene.gameDelegate = gameViewModel
            view.presentScene(scene)

            
            skView = view
            
//            skView?.showsFPS = true
//            skView?.showsNodeCount = true
//            skView?.ignoresSiblingOrder = true
        }
    }
}

