//
//  Level.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 04.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct Level {
    var number: Int
    var limits: [Int]
    
    var board: Board
    var hero: Hero
}

extension Level : CustomStringConvertible {
    var description: String {
        guard let levelData = LevelDataToLevelAdapter().adapt(self) else { return "Empty Board" }
        
        return levelData.description
    }
}