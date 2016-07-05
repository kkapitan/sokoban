//
//  HeroNode.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation
import SpriteKit


extension SKNode {
    
    func childNodeWithIdentifier(id: NodeIdentifiers) -> SKNode? {
        return self.childNodeWithName(id.name)
    }
}

class HeroNode : SKSpriteNode {

}