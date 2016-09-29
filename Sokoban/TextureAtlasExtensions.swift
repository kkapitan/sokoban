//
//  TextureAtlasExtensions.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 09.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import SpriteKit

enum AtlasIdentifier : String {
    case Stoneblocks = "StoneblocksAtlas"
    case Boxes = "BoxesAtlas"
    case HeroMove = "HeroMoveAtlas"
    case HeroIdle = "HeroIdleAtlas"
    case HeroPush = "HeroPushAtlas"
}

extension SKTextureAtlas {
    func randomTexture() -> SKTexture {
        let textureName = self.textureNames.randomElement()
        return textureNamed(textureName)
    }
}

extension SKTextureAtlas {
    convenience init(identifier: AtlasIdentifier) {
        self.init(named: identifier.rawValue)
    }
}

extension SKTextureAtlas {
    var textures: [SKTexture] {
        return textureNames.sort().map { textureNamed($0) }
    }
}

