//
//  GameManager.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 05.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct GameManager {
    private(set) var isMoving: Bool = false
    
    let context : TransitionContext
    
    mutating func moveTo(at: GridPoint, completion: ((context: TransitionContext?) -> ())?) {
        let movementAction = HeroMovementAction(level: context.level, to: at)

        guard let transition = movementAction.applyAction() else {
            completion?(context: nil)
            return
        }
        
        transition.apply(context, animated: true, completion: completion)
    }
    
    mutating func pushBox(at: GridPoint, completion: ((context: TransitionContext?) -> ())?) {
        let pushAction = PushBoxAction(level: context.level, boxPosition: at)
        
        guard let transition = pushAction.applyAction() else {
            completion?(context: nil)
            return
        }
        
        transition.apply(context, animated: true, completion: completion)
    }
    
    init(context: TransitionContext) {
        self.context = context
    }
}
