//
//  BoardToNodeAdapter.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation
import SpriteKit

struct BoardToNodeAdapter : OneSideAdaptable {
    typealias FromValue = Board
    typealias ToValue = SKNode
    
    func adapt(from: Board) -> SKNode? {
        return nil
    }
}