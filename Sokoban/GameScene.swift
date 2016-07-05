//
//  GameScene.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 30.06.2016.
//  Copyright (c) 2016 CappSoft. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    private(set) var boardNode : BoardNode?
    var gameDelegate: GameSceneDelegate?
    
    init(size: CGSize, boardNode: BoardNode) {
        super.init(size: size)
        
        self.boardNode = boardNode
        self.addChild(boardNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let touch = touches.first, boardNode = boardNode else { return }
        
        let positionInScene = touch.locationInNode(self)
        let positionInBoardNode = touch.locationInNode(boardNode)
        
        let touchedSceneNode = self.nodeAtPoint(positionInScene)
        let touchedBoardNode = boardNode.nodeAtPoint(positionInBoardNode)
        
        if let _ = touchedSceneNode as? GameScene {
            return
        }
        
        gameDelegate?.boardNode(boardNode, didTouchNode: touchedBoardNode, atPoint: positionInBoardNode)
        
        print(touchedBoardNode.dynamicType, touchedSceneNode.dynamicType)
        
    }
}
