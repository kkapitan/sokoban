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
    
    func elementsMatching(function: (Element) -> Bool) -> [Element]
}

extension QuerableGridType {
    func elementsMatching(function: (Element) -> Bool) -> [Element] {
        return self.grid.flatMap({$0}).filter(function)
    }
}