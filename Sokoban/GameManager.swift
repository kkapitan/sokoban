//
//  GameManager.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 05.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

protocol GameManagerDelegate: class {
    func gameManagerDidDetectWiningState(manager: GameManager)
}

struct GameManager {
    private(set) var undoStack: UndoStack = UndoStack()
    
    let context: TransitionContext
    weak var delegate: GameManagerDelegate?
    
    
    func moveTo(at: GridPoint, completion: ((context: TransitionContext?) -> ())?) {
        let movementAction = HeroMovementAction(level: context.level, to: at)

        guard let transition = movementAction.applyAction() else {
            completion?(context: nil)
            return
        }
        
        transition.apply(context, animated: true, completion: completion)
    }
    
    func pushBox(at: GridPoint, completion: ((context: TransitionContext?) -> ())?) {
        let pushAction = PushBoxAction(level: context.level, boxPosition: at)
        
        guard let transition = pushAction.applyAction() else {
            completion?(context: nil)
            return
        }
        
        transition.apply(context, animated: true) { (context) in
            completion?(context: context)
            
            if (self.gameWon(context)) {
                self.delegate?.gameManagerDidDetectWiningState(self)
            }

        }
    }
    
    func undo() {
        
    }
    
    private func gameWon(context: TransitionContext) -> Bool {
        return context.level.board.boxes() == context.level.board.boxesPlaced()
    }
    
    init(context: TransitionContext) {
        self.context = context
    }
}
