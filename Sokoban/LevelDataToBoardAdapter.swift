//
//  LevelDataToBoardAdapter.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct StringToFieldsAdapter : OneSideAdaptable {
    typealias FromValue = String
    typealias ToValue = [Field]
    
    func adapt(from: String) -> [Field]? {
        return from.characters.map({ Field(rawValue: String($0)) }).flatMap {$0}
    }
}

struct LevelDataToBoardAdapter : TwoSideAdaptable {
    typealias FromValue = LevelData
    typealias ToValue = Board
    
    let adapter = StringToFieldsAdapter()
    
    func adapt(from: LevelData) -> Board? {
        let width = from.width
        let height = from.height
        
        //Map array of strings to array of array of fields
        let grid = from.gridStrings.map({ adapter.adapt($0) }).flatMap {$0}
        
        //Check if grid has proper dimensions (every row has been mapped correctly)
        guard grid.filter({$0.count == width}).count == height else { return nil }
        
        return Board(width: width, height: height, grid: grid)
    }
    
    func adapt(from: Board) -> LevelData? {
        let width = from.width
        let height = from.height
        
        let gridStrings = from.grid.map({
            $0.reduce("", combine: { $0.stringByAppendingString($1.rawValue) })
        })
        
        return LevelData(width: width, height: height, gridStrings: gridStrings)
    }
}
