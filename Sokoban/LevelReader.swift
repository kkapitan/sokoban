//
//  LevelReader.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 11.09.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct LevelReader {
    func readLevelData(number: Int) -> LevelData? {
        let jsonPathOptional = NSBundle.mainBundle().pathForResource("level\(number)", ofType: "json")
        
        return readLevelData(jsonPathOptional)
    }
    
    func readLevelData(name: String) -> LevelData? {
        let jsonPathOptional = NSBundle.mainBundle().pathForResource(name, ofType: "json")
        
        return readLevelData(jsonPathOptional)
    }
    
    private func readLevelData(path: String?) -> LevelData? {
        guard let jsonPath = path, jsonData = NSData(contentsOfFile: jsonPath) else { return nil }
        
        do {
            guard let json =  try NSJSONSerialization.JSONObjectWithData(jsonData, options: .AllowFragments) as? NSDictionary else { return nil }
            
            return JSONToLevelDataAdapter().adapt(json)
        } catch {
            return nil
        }
    }
}
