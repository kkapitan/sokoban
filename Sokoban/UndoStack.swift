//
//  UndoStack.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct UndoStack {
    var actions: [ReversibleActionType]
    
    mutating func pushAction(action: ReversibleActionType) {
        self.actions.append(action)
    }
    
    mutating func popAction() -> Transition? {
        guard let action = self.actions.last else { return nil }
        
        return action.reverseAction()
    }
}

