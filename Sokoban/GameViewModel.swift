//
//  GameViewModel.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 05.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation
import SpriteKit

protocol GameSceneDelegate: class {
    func boardNode(boardNode: BoardNode, didTouchNode node: SKNode, atPoint: CGPoint)
}

class GameViewModel {
    private(set) var manager: GameManager?
    private(set) var isMoving: Bool = false
    
    private var levelData: LevelData
    private var movementCounter: Int
    
    weak var delegate: GameViewModelDelegate?
    
    init(levelData: LevelData) {
        self.levelData = levelData
        movementCounter = 0
    }
}

extension GameViewModel {
    
    func initLevel() -> BoardNode? {
            
        guard let level = LevelDataToLevelAdapter().adapt(levelData) else { return nil }
            
        guard let boardNode = BoardNode(level: level) else { return nil }
            
        let context = NodeTransitionContext(level: level, boardNode: boardNode)
            
        self.manager = GameManager(context: context)
        self.manager?.delegate = self
            
        return boardNode
    }
}

extension GameViewModel : GameManagerDelegate {
    func gameManagerDidDetectWiningState(manager: GameManager) {
        NSUserDefaults.standardUserDefaults().registerScore(movementCounter, level: levelData)
        
        let limits = levelData.markLimits
        
        let greaterThan = limits.filter { $0 >= movementCounter }.count
        let mark = greaterThan + 1
        
        NSUserDefaults.standardUserDefaults().registerMark(mark, level:levelData)
        
        delegate?.gameViewModel(self, didWinLevelWithMark: mark)
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
        
        movementCounter = movementCounter + 1
        delegate?.gameViewModel(self, didUpdateMovementCount: movementCounter)
    }
}