//
//  PushBoxTransitions.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct PushBoxTransition : StateTransition {
    
    let heroPosition: GridPoint
    let boxPosition: GridPoint
    
    let direction: Direction
    
    func changeState(context: TransitionContext) -> TransitionContext {
        context.hero.position = boxPosition
        
        return context
    }
    
    func animateWithContext(context: TransitionContext, completion: () -> ()) {
        context.animatePush(heroPosition, boxPosition: boxPosition, direction: direction, completion: completion)
    }
}
