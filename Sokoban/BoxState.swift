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
    
    init(field: Field) {
        switch field {
        case .OccupiedDropzone:
            self = .Placed
        default:
            self = .Missplaced
        }
    }
}

