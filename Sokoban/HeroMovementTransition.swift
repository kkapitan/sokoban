//
//  HeroMovementTransition.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct HeroMovementTransition : StateTransition {
    let from: GridPoint
    let to: GridPoint
    
    func changeState(context: TransitionContext) -> TransitionContext {
        context.hero.position = to
        
        return context
    }
    
    func animateWithContext(context: TransitionContext, completion: () -> ()) {
        context.animateMovement(from, to: to, completion: completion)
    }
}