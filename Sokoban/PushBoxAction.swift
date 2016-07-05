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
    
    let level: Level
    let boxPosition: GridPoint
    
    func applyAction() -> Transition? {
        guard let field = level.board[boxPosition] where field.containsBox() else { return nil }
        
        let directions = Direction.allDirections()
        
        let possibleOrientations = directions.map({
            Orientation(position: $0.gridPointFollowingDirection(boxPosition), direction: $0.opositeDirection())
        })
        
        guard let heroOrientation = possibleOrientations.filter({$0.position == level.hero.position}).first else { return nil }
        
        let newBoxPosition = heroOrientation.direction.gridPointFollowingDirection(boxPosition)
        
        guard let newField = level.board[newBoxPosition] where newField.isMovementValid() else { return nil }
        
        let preBoxState = BoxState.currentState(field)
        let postBoxState = BoxState.stateAfterMovingToField(newField)
        
        let pushTransition = PushBoxTransition(boxPosition: boxPosition,
                                               nextPosition: newBoxPosition)
        
        let boxStateTransition = BoxStateTransition(boxPosition: boxPosition, nextPosition: newBoxPosition, fromState: preBoxState, toState: postBoxState)
        
        return ChainedTransition(transitions: [pushTransition, boxStateTransition])
    }
    
    func reverseAction() -> Transition? {
        return nil
    }
}

