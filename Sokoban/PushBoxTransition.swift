//
//  PushBoxTransitions.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct PushBoxTransition : StateTransition {
    
    let boxPosition: GridPoint
    let nextPosition: GridPoint
    
    func changeState(context: TransitionContext) -> TransitionContext {
        context.level.hero.position = boxPosition
        
        return context
    }
    
    func animateWithContext(context: TransitionContext, completion: () -> ()) {
        context.animatePush(boxPosition, nextBoxPosition: nextPosition, completion: completion)
    }
}
