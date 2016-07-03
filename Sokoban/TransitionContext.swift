//
//  TransitionContext.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

protocol TransitionContext : class {
    var board: Board { get set }
    var hero: Hero { get set }
    
    func animateMovement(from: GridPoint, to: GridPoint, completion: () -> ())
    func animatePush(heroPosition: GridPoint, boxPosition: GridPoint, direction: Direction, completion: () -> ())
    func animateBoxState(boxPosition: GridPoint, state: BoxState, completion: () -> ())
}

