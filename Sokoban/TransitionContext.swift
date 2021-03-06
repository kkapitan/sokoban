//
//  TransitionContext.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation
import SpriteKit

protocol TransitionContext : class {
    var level: Level { get  set}
    
    func animateIdleState(completion: () -> ())
    func animateMovement(from: GridPoint, to: GridPoint, completion: () -> ())
    func animatePush(boxPosition: GridPoint, nextBoxPosition: GridPoint, completion: () -> ())
    func animateBoxStateTransition(boxPosition: GridPoint, fromState:BoxState, toState: BoxState, completion: () -> ())
}

class NodeTransitionContext : TransitionContext {
    
    var level: Level
    var boardNode: BoardNode
    
    func animateIdleState(completion: () -> ()) {
        guard let movingNode = boardNode.childNodeWithIdentifier(.HeroIdentifier) as? HeroNode else {
            completion()
            return
        }
        
        movingNode.heroState = .Idle
        completion()
    }
    
    func animateMovement(from: GridPoint, to: GridPoint, completion: () -> ()) {
        
        let pointToNode = GridPointToCGPointAdapter(board: level.board)
        
        guard let destinationPoint = pointToNode.adapt(to) else {
            completion()
            return
        }
        
        guard let movingNode = boardNode.childNodeWithIdentifier(.HeroIdentifier) as? HeroNode else {
            completion()
            return
        }
        
        let direction = Direction(from: from, to: to)
        movingNode.heroState = .Moving(direction)
        
        let movementAction = SKAction.moveTo(destinationPoint, duration: 0.2)
        
        movingNode.runAction(movementAction, completion: completion)
    }
    
    func animatePush(boxPosition: GridPoint, nextBoxPosition: GridPoint, completion: () -> ()) {
        let pointToNode = GridPointToCGPointAdapter(board: level.board)
        
        
        guard let boxDestinationPoint = pointToNode.adapt(nextBoxPosition) else {
            completion()
            return
        }
        
        guard let heroDestinationPoint = pointToNode.adapt(boxPosition) else {
            completion()
            return
        }
        
        guard let heroNode = boardNode.childNodeWithIdentifier(.HeroIdentifier) as? HeroNode else {
            completion()
            return
        }
        
        let direction = Direction(from: boxPosition, to: nextBoxPosition)
        heroNode.heroState = .Pushing(direction)
        
        let boxNode = boardNode.nodeAtPoint(heroDestinationPoint)
        
        let boxMovementAction = SKAction.moveTo(boxDestinationPoint, duration: 0.2)
        let heroMovementAction = SKAction.moveTo(heroDestinationPoint, duration: 0.2)
        
        let boxAction = SKAction.runBlock { 
            boxNode.runAction(boxMovementAction)
        }
        
        let heroAction = SKAction.runBlock {
            heroNode.runAction(heroMovementAction)
        }
        
        let action = SKAction.group([boxAction, heroAction])
        boardNode.runAction(SKAction.sequence([action, SKAction.waitForDuration(0.3)]), completion:completion)
    }
    
    func animateBoxStateTransition(boxPosition: GridPoint, fromState:BoxState, toState: BoxState, completion: () -> ()) {
        let pointToNode = GridPointToCGPointAdapter(board: level.board)
        
        guard let boxNodePoint = pointToNode.adapt(boxPosition) else {
            completion()
            return
        }
        
        guard fromState != toState else {
            completion()
            return
        }
        
        let boxNode = boardNode.nodeAtPoint(boxNodePoint)
        let blendFactor: CGFloat = toState == .Placed ? 0.5 : 0
        
        let action = SKAction.colorizeWithColor(UIColor.redColor(), colorBlendFactor: blendFactor, duration: 0.1)
        boxNode.runAction(action, completion: completion)
    }
    
    init(level: Level, boardNode: BoardNode) {
        self.level = level
        self.boardNode = boardNode
    }
}

