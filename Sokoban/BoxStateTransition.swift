//
//  BoxStateTransition.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

protocol BoxStateTransition : StateTransition {
    var at: GridPoint { get }
    var state: BoxState { get }
}

extension BoxStateTransition {
    
    func animateWithContext(context: TransitionContext, completion: () -> ()) {
        context.animateBoxState(at, state: state, completion: completion)
    }
}

struct PrePushBoxStateTransition : BoxStateTransition {
    let at: GridPoint
    let state: BoxState
    
    func changeState(context: TransitionContext) -> TransitionContext {
        var board = context.board
        
        let newField = state == .Missplaced ? Field.Empty : Field.FreeDropzone
        board.changeField(at, to: newField)
        
        context.board = board
        return context
    }
}

struct PostPushBoxStateTransition : BoxStateTransition {
    let at: GridPoint
    let state: BoxState
    
    func changeState(context: TransitionContext) -> TransitionContext {
        var board = context.board
        
        let newField = state == .Missplaced ? Field.Box : Field.OccupiedDropzone
        board.changeField(at, to: newField)
        
        context.board = board
        return context
    }
}
