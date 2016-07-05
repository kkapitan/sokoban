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

struct LevelDataToLevelAdapter : TwoSideAdaptable {
    typealias FromValue = LevelData
    typealias ToValue = Level
    
    let adapter = StringToFieldsAdapter()
    
    func adapt(from: LevelData) -> Level? {
        let width = from.width
        let height = from.height
        
        //Map array of strings to array of array of fields
        let grid = from.gridStrings.map({ adapter.adapt($0) }).flatMap {$0}
        
        //Check if grid has proper dimensions (every row has been mapped correctly)
        guard grid.filter({$0.count == width}).count == height else { return nil }
        
        let board = Board(width: width, height: height, grid: grid)
        
        guard let heroData = board.elementsMatching({ $0 == .Hero }).first else { return nil }
        
        let heroPoint = GridPoint(x: heroData.0.x, y: heroData.0.y)
        let hero = Hero(position: heroPoint)
        
        return Level(board: board, hero: hero)
    }
    
    func adapt(from: Level) -> LevelData? {
        let width = from.board.width
        let height = from.board.height
        
        let gridStrings = from.board.grid.map({
            $0.reduce("", combine: { $0.stringByAppendingString($1.rawValue) })
        })
        
        return LevelData(width: width, height: height, gridStrings: gridStrings)
    }
}
