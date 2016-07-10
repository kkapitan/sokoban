//
//  Field.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

enum Field : String {
    case Wall = "w"
    case Box = "b"
    case Hero = "h"
    case FreeDropzone = "f"
    case OccupiedDropzone = "o"
    case Empty = "e"
    case Outside = "x"
    
    func isMovementValid() -> Bool {
        return [.Empty, .FreeDropzone, .Hero].contains(self)
    }
    
    func containsBox() -> Bool {
        return [.Box, .OccupiedDropzone].contains(self)
    }
}
