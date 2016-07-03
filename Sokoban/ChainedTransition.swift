//
//  ChainedTransition.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct ChainedTransition {
    let transitions: [Transition]
}

extension ChainedTransition : Transition {
    
    func apply(context: TransitionContext, animated: Bool, completion: ((context: TransitionContext) -> ())?) {
        self.applyTransition(0, context: context, animated: animated, completion: completion)
    }
    
    private func applyTransition(index: Int, context: TransitionContext, animated: Bool, completion: ((context: TransitionContext) -> ())?) {
        guard let transition = self.transitions[safe: index] else {
            completion?(context: context)
            return
        }
        
        transition.apply(context, animated: animated) { innerContext in
            self.applyTransition(index + 1, context: innerContext, animated: animated, completion: completion)
        }
    }
}
