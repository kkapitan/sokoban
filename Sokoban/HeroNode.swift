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

enum HeroState {
    case Moving(Direction)
    case Pushing(Direction)
    case Idle
}

class HeroNode : SKSpriteNode {
    let moveAtlas = SKTextureAtlas(identifier: .HeroMove)
    let idleAtlas = SKTextureAtlas(identifier: .HeroIdle)
    let pushAtlas = SKTextureAtlas(identifier: .HeroPush)
    
    var heroState: HeroState = .Idle {
        willSet {
            switch newValue {
            case .Moving(let direction):
                move(direction)
                break
            case .Pushing(let direction):
                push(direction)
                break
            case .Idle:
                idle()
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        let texture = moveAtlas.textures[0]
    
        super.init(texture: texture, color: UIColor.clearColor(), size: CGSizeMake(tileSize, tileSize))
        
        zPosition = 5
        
        idle()
    }
    
    

    private func turn(direction: Direction) {
        switch direction {
        case .Right: turnRight()
            break
        case .Left: turnLeft()
            break
        case .Up: turnUp()
            break
        case .Down: turnDown()
            break
        }
    }
    
    private func move(direction: Direction) {
        turn(direction)

        if case .Moving(_) = heroState { return }
        
        animateTextureAtlas(moveAtlas)
    }
    
    private func idle() {
        if case .Idle = heroState { return }
        
        animateTextureAtlas(idleAtlas)
    }
    
    private func push(direction: Direction) {
        turn(direction)
        
        if case .Pushing(_) = heroState { return }
        
        animateTextureAtlas(pushAtlas)
    }
    
    private func turnRight() {
        xScale = 1.0
        zRotation = 0.0
    }
    
    private func turnLeft() {
        xScale = -1.0
        zRotation = 0.0
    }
    
    private func turnUp() {
        zRotation = -xScale * CGFloat(M_PI/2)
    }
    
    private func turnDown() {
        zRotation = xScale * CGFloat(M_PI/2)
    }
    
    private func animateTextureAtlas(atlas: SKTextureAtlas) {
        let movementActionKey = "Movement"
        
        removeActionForKey(movementActionKey)
        
        let animateAction = SKAction.animateWithTextures(atlas.textures, timePerFrame: 0.1, resize: false, restore: true)
        
        let foreverAction = SKAction.repeatActionForever(animateAction)
        
        runAction(foreverAction, withKey: movementActionKey)
    }
}