//
//  BoardToNodeAdapter.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation
import SpriteKit

extension CGPoint {
    func translateBy(vector: CGPoint) -> CGPoint {
        return CGPointMake(self.x + vector.x, self.y + vector.y)
    }
}

struct GridPointToCGPointAdapter : TwoSideAdaptable {
    typealias FromValue = GridPoint
    typealias ToValue = CGPoint
    
    let board: Board
    
    func adapt(from: CGPoint) -> GridPoint? {
        
        let translation = CGPointMake(-tileSize/2, -tileSize/2)
        let translatedPoint = from.translateBy(translation)
        
        let x = Int(translatedPoint.x / tileSize)
        let y = board.height - 1 - Int(translatedPoint.y / tileSize)
        
        return GridPoint(x: x, y: y)
    }
    
    func adapt(from: GridPoint) -> CGPoint? {
        let x = CGFloat(from.x) * tileSize
        let y = CGFloat(board.height - 1 - from.y) * tileSize
        
        let translation = CGPointMake(tileSize/2, tileSize/2)
        return CGPointMake(x, y).translateBy(translation)
    }
}
