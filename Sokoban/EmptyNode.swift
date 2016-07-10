//
//  EmptyNode.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 09.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import SpriteKit

class EmptyNode : SKSpriteNode {
    let atlas = SKTextureAtlas(identifier: .Stoneblocks)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        let texture = atlas.randomTexture()
        
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(tileSize, tileSize))
        self.alpha = 0.5
    }
}

