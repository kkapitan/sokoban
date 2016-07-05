//
//  GridType.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

protocol GridType {
    associatedtype Element
    
    var grid: [[Element]] { get }
}

protocol QuerableGridType : GridType {
    
    func elementsMatching(function: (Element) -> Bool) -> [(Coordinates, Element)]
}

typealias Coordinates = (x: Int, y: Int)

extension QuerableGridType {
    func elementsMatching(function: (Element) -> Bool) -> [(Coordinates, Element)] {
        var elements: [(Coordinates, Element)] = []
        
        for (y, row) in grid.enumerate() {
            for (x, field) in row.enumerate() {
                if function(field) {
                    elements.append((Coordinates(x, y), field))
                }
            }
        }
        
        return elements
    }
}