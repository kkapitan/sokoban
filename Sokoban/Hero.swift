//
//  Hero.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 30.06.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct Hero {
    var position: GridPoint
}

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

