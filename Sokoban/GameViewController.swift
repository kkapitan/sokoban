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
    private(set) var level: Level?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let skView = self.view as! SKView
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        
        let scene = GameScene(size: self.view.bounds.size)
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
        
        if let levelNode = readLevel() {
            scene.addChild(levelNode)
            
            guard let lvl = level else { return }
            
            let context = NodeTransitionContext(level: lvl, boardNode: levelNode)
            
            HeroMovementAction(level: lvl, to: GridPoint(x:1,y:1)).applyAction()?.apply(context, animated: true, completion: { (context) in
                print(context.level)
                PushBoxAction(level: context.level, boxPosition: GridPoint(x:2, y:1)).applyAction()?.apply(context, animated: true, completion: { (context) in
                    print(context.level)
                    PushBoxAction(level: context.level, boxPosition: GridPoint(x:3, y:1)).applyAction()?.apply(context, animated: true, completion: { (context) in
                        print(context.level)
                        PushBoxAction(level: context.level, boxPosition: GridPoint(x:4, y:1)).applyAction()?.apply(context, animated: true, completion: { (context) in
                            print(context.level)
                        })
                    })

                })
            })
        }
        
    }

    func readLevel() -> BoardNode? {
        
        let jsonPathOptional = NSBundle.mainBundle().pathForResource("level", ofType: "json")
        guard let jsonPath = jsonPathOptional, jsonData = NSData(contentsOfFile: jsonPath) else { return nil }
        
        do {
            let json =  try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as? NSDictionary
            let levelData = JSONToLevelDataAdapter().adapt(json!)
            let levelOptional = LevelDataToLevelAdapter().adapt(levelData!)
            
            guard let level = levelOptional else { return nil }
        
            self.level = level
            print(level)
            
            return BoardNode(level: level)
        } catch {
            return nil
        }
    }
}
