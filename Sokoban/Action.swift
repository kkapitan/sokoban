//
//  Actions.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 01.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

protocol ActionType {
    var level: Level { get }
    
    func applyAction() -> Transition?
}

protocol ReversibleActionType : ActionType {
    func reverseAction() -> Transition?
}
