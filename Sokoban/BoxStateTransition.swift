//
//  BoxStateTransition.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct BoxStateTransition : StateTransition {
    let boxPosition: GridPoint
    let nextPosition: GridPoint
    
    let fromState: BoxState
    let toState: BoxState
    
    func changeState(context: TransitionContext) -> TransitionContext {
        var board = context.level.board
        
        let newField = toState == .Missplaced ? Field.Box : Field.OccupiedDropzone
        board.changeField(nextPosition, to: newField)
        
        let oldField = fromState == .Missplaced ? Field.Empty : Field.FreeDropzone
        board.changeField(boxPosition, to: oldField)
        
        context.level.board = board
        return context
    }
    
    func animateWithContext(context: TransitionContext, completion: () -> ()) {
        context.animateBoxStateTransition(nextPosition, fromState: fromState, toState: toState, completion: completion)
    }

}
