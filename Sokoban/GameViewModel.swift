//
//  GameViewModel.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 05.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation
import SpriteKit

protocol GameSceneDelegate {
    func boardNode(boardNode: BoardNode, didTouchNode node: SKNode, atPoint: CGPoint)
}

class GameViewModel {
    private(set) var manager: GameManager?
    private(set) var isMoving: Bool = false
}

extension GameViewModel {
    
    func readLevel() -> BoardNode? {
        
        let jsonPathOptional = NSBundle.mainBundle().pathForResource("levelbig", ofType: "json")
        
        guard let jsonPath = jsonPathOptional, jsonData = NSData(contentsOfFile: jsonPath) else { return nil }
        
        do {
            guard let json =  try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as? NSDictionary else { return nil }
            
            guard let levelData = JSONToLevelDataAdapter().adapt(json) else { return nil }
            
            guard let level = LevelDataToLevelAdapter().adapt(levelData) else { return nil }
            
            guard let boardNode = BoardNode(level: level) else { return nil }
            
            let context = NodeTransitionContext(level: level, boardNode: boardNode)
            
            self.manager = GameManager(context: context)
            self.manager?.delegate = self
            
            return boardNode
        } catch {
            return nil
        }
    }
}

extension GameViewModel : GameManagerDelegate {
    func gameManagerDidDetectWiningState(manager: GameManager) {
        print("WIN WIN WIN")
    }
}

extension GameViewModel : GameSceneDelegate {
    func boardNode(boardNode: BoardNode, didTouchNode node: SKNode, atPoint: CGPoint) {
        guard let manager = manager where isMoving == false else { return }
        
        isMoving = true
        
        let board = manager.context.level.board
        let gridToPoint = GridPointToCGPointAdapter(board: board)
        
        guard let gridPoint = gridToPoint.adapt(atPoint) else { return }
        
        if let _ = node as? BoxNode {
            manager.pushBox(gridPoint, completion: { (context) in
                self.isMoving = false
            })
        } else {
            manager.moveTo(gridPoint, completion: { (context) in
                self.isMoving = false
            })
        }
    }
}