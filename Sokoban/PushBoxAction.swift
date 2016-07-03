//
//  PushBoxAction.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

typealias Orientation = (position: GridPoint, direction: Direction)

struct PushBoxAction : ReversibleActionType {
    
    let board: Board
    let hero: Hero
    
    let boxPosition: GridPoint
    
    func applyAction() -> Transition? {
        guard let field = board[boxPosition] where field.containsBox() else { return nil }
        
        let directions = Direction.allDirections()
        
        let possibleOrientations = directions.map({
            Orientation(position: $0.gridPointFollowingDirection(boxPosition), direction: $0.opositeDirection())
        })
        
        guard let heroOrientation = possibleOrientations.filter({$0.position == hero.position}).first else { return nil }
        
        let newBoxPosition = heroOrientation.direction.gridPointFollowingDirection(boxPosition)
        
        guard let newField = board[newBoxPosition] where newField.isMovementValid() else { return nil }
        
        let preBoxState = BoxState(field: field)
        let postBoxState = BoxState(field: newField)
        
        let preStateTransition = PrePushBoxStateTransition(at: boxPosition,
                                                           state: preBoxState)
        
        let pushTransition = PushBoxTransition(heroPosition: heroOrientation.position,
                                               boxPosition: boxPosition,
                                               direction: heroOrientation.direction)
        
        let postStateTransition = PostPushBoxStateTransition(at: newBoxPosition,
                                                             state: postBoxState)
        
        
        return ChainedTransition(transitions: [preStateTransition, pushTransition, postStateTransition])
    }
    
    func reverseAction() -> Transition? {
        return nil
    }
}

