//
//  WallNode.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation
import SpriteKit

class WallNode : SKSpriteNode {
    let atlas = SKTextureAtlas(identifier: .Stoneblocks)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        let texture = atlas.randomTexture()
        
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(tileSize, tileSize))
        self.zPosition = 3
    }
}