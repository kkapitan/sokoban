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
        
        let jsonPathOptional = NSBundle.mainBundle().pathForResource("level", ofType: "json")
        guard let jsonPath = jsonPathOptional, jsonData = NSData(contentsOfFile: jsonPath) else { return nil }
        
        do {
            let json =  try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as? NSDictionary
            let levelData = JSONToLevelDataAdapter().adapt(json!)
            let levelOptional = LevelDataToLevelAdapter().adapt(levelData!)
            
            guard let level = levelOptional else { return nil }
            
            guard let boardNode = BoardNode(level: level) else { return nil }
            
            let context = NodeTransitionContext(level: level, boardNode: boardNode)
            self.manager = GameManager(context: context)
            
            return boardNode
        } catch {
            return nil
        }
    }
}

extension GameViewModel : GameSceneDelegate {
    func boardNode(boardNode: BoardNode, didTouchNode node: SKNode, atPoint: CGPoint) {
        guard var manager = manager where isMoving == false else { return }
        
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