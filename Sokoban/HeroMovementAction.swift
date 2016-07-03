//
//  HeroMovementAction.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct HeroMovementAction : ReversibleActionType {
    let board: Board
    let hero: Hero
    
    let to: GridPoint
    
    func applyAction() -> Transition? {
        return movementTransitionFrom(hero.position, to: to)
    }
    
    func reverseAction() -> Transition? {
        return movementTransitionFrom(to, to: hero.position)
    }
    
    private func movementTransitionFrom(from: GridPoint, to: GridPoint) -> ChainedTransition? {
        let pathFinder = PathFinder(board: board)
        
        //Check if path exists
        guard let path = pathFinder.pathFrom(from, to: to) else { return nil }
        
        //Make a copy of array translated by one allowing to zip two arrays into one containing pairs of consecutive points
        let pathSlice = Array(path[1..<path.count])
        
        //Mapping is required since swift is not able to figure out that HeroMovementTransition conforms to Transition
        let transitions = zip(path, pathSlice).map ({
            HeroMovementTransition(from:$0, to:$1) as Transition
        })
        
        return ChainedTransition(transitions: transitions)
    }
}
