//
//  UndoStack.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct UndoStack {
    private (set) var actions: [ReversibleActionType] = []
    private (set) var currentAction: Int = 0
    
    
    mutating func registerAction(action: ReversibleActionType) {
        var slice = Array(actions[0..<currentAction])
        slice.append(action)
        
        currentAction += 1
        actions = slice
    }
    
    mutating func undoAction() -> Transition? {
        guard let action = self.actions[safe: currentAction] else { return nil }
        currentAction -= 1
        
        return action.reverseAction()
    }
    
    mutating func redoAction() -> Transition? {
        guard let action = self.actions[safe: currentAction + 1] else { return nil }
        currentAction += 1
        
        return action.reverseAction()
    }
}

