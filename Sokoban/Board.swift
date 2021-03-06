//
//  Board.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 01.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct Board {
    
    let width: Int
    let height: Int
    
    private(set) var grid: [[Field]]
    
    subscript(point: GridPoint) -> Field? {
        guard checkBounds(point) == true else { return nil }

        return grid[point.y][point.x]
    }
    
    mutating func changeField(at:GridPoint, to:Field) {
        guard checkBounds(at) == true else { return }
        
        grid[at.y][at.x] = to
    }
    
    private func checkBounds(point: GridPoint) -> Bool {
        guard point.x < width && point.x >= 0 else { return false }
        guard point.y < height && point.y >= 0 else { return false }
        
        return true
    }
}

extension Board : QuerableGridType {
    
    func boxesPlaced() -> Int {
        return elementsMatching({ $0 == .OccupiedDropzone}).count
    }
    
    func boxes() -> Int {
        return elementsMatching({ $0.containsBox() }).count
    }
}


