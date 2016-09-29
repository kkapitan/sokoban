//
//  Direction.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

enum Direction {
    case Up, Down, Left, Right
    
    func gridPointFollowingDirection(point: GridPoint) -> GridPoint {
        switch self {
        case .Up:
            return GridPoint(x: point.x , y: point.y - 1)
        case .Down:
            return GridPoint(x: point.x , y: point.y + 1)
        case .Left:
            return GridPoint(x: point.x + 1, y: point.y)
        case .Right:
            return GridPoint(x: point.x - 1, y: point.y)
        }
    }
    
    func opositeDirection() -> Direction {
        switch self {
        case .Up:
            return .Down
        case .Down:
            return .Up
        case .Left:
            return .Right
        case .Right:
            return .Left
        }
    }
    
    static func allDirections() -> [Direction] {
        return [.Up, .Down, .Left, .Right]
    }
    
    init(from: GridPoint, to: GridPoint) {
        if from.x < to.x { self = .Right }
        
        else if from.x > to.x { self = .Left }
        
        else if from.y > to.y { self = .Down }
        
        else { self = .Up }
    }
}

