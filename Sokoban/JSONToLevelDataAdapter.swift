//
//  JSONToLevelDataAdapter.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct JSONToLevelDataAdapter : OneSideAdaptable {
    typealias FromValue = NSDictionary
    typealias ToValue = LevelData
    
    func adapt(from: NSDictionary) -> LevelData? {
        
        //Get dimensions
        guard let width = from.valueForKey("width")?.integerValue else { return nil }
        guard let height = from.valueForKey("height")?.integerValue else { return nil }
        
        //Get array of strings representing grid
        guard let gridArray = from.valueForKey("board") as? [String] else { return nil }
        
        return LevelData(width: width, height: height, gridStrings: gridArray)
    }
}

