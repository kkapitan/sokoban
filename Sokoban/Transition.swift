//
//  Transitions.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 01.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

protocol Transition {
    func apply(context: TransitionContext, animated: Bool, completion: ((context: TransitionContext) -> ())?)
}

protocol StateTransition : Transition {
    func changeState(context: TransitionContext) -> TransitionContext
    
    func animateWithContext(context: TransitionContext, completion: () -> ())
}

extension StateTransition {
    func apply(context: TransitionContext, animated: Bool, completion: ((context: TransitionContext) -> ())?) {
        
        if animated {
            animateWithContext(context, completion: {
                let newContext = self.changeState(context)
                completion?(context: newContext)
            })
        } else {
            let newContext = changeState(context)
            completion?(context: newContext)
        }
    }
}
