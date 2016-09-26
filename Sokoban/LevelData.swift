//
//  LevelData.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 01.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct LevelData {
    let id: Int
    let markLimits: [Int]
    
    let width: Int
    let height: Int
    
    let gridStrings: [String]
}

extension LevelData : CustomStringConvertible {
    var description: String {
        return gridStrings.reduce("") {
            $0.stringByAppendingString($1).stringByAppendingString("\n")
        }
    }
}