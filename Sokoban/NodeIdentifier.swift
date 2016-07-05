//
//  NodeIdentifier.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 05.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

enum NodeIdentifiers {
    case HeroIdentifier
    case Box(p: GridPoint)
    case Dropzone(p: GridPoint)
    
    var name: String {
        switch self {
        case .HeroIdentifier:
            return "Hero_Identifier"
        case .Box(let point):
            return "Box_Identifier \(point.description)"
        case .Dropzone(let point):
            return "Dropzone_Identifier \(point.description)"
        }
    }
}