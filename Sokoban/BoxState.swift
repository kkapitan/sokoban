//
//  BoxState.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

enum BoxState {
    case Missplaced
    case Placed
    
    static func currentState(field: Field) -> BoxState {
        switch field {
        case .OccupiedDropzone:
            return Placed
        default:
            return Missplaced
        }
    }
    
    static func stateAfterMovingToField(field: Field) -> BoxState {
        switch field {
        case .FreeDropzone:
            return Placed
        default:
            return Missplaced
        }
    }
    

}

