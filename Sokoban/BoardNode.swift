//
//  BoardNode.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 03.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation
import SpriteKit

let tileSize : CGFloat = 44.0
let size = CGSizeMake(tileSize, tileSize)

class BoardNode : SKNode {
    init?(level: Level) {
        super.init()
        let pointAdapter = GridPointToCGPointAdapter(board: level.board)
        
        for (y, row) in level.board.grid.enumerate() {
            for (x, field) in row.enumerate() {
                
                let gridPoint = GridPoint(x: x, y: y)
                
                guard let position = pointAdapter.adapt(gridPoint) else { return nil }
                
                if let spriteNode = spriteNodeForField(field) {
                    spriteNode.position = position
                    spriteNode.zPosition = zIndexForField(field)
                    self.addChild(spriteNode)
                }
            }
        }
        
        guard let heroPoint = pointAdapter.adapt(level.hero.position) else { return nil }
        
        let heroNode = HeroNode(color: UIColor.greenColor(), size: size)
        heroNode.name = NodeIdentifiers.HeroIdentifier.name
        heroNode.position = heroPoint
        heroNode.zPosition = 5
        
        self.addChild(heroNode)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoardNode {
    private func spriteNodeForField(field: Field) -> SKSpriteNode? {
        switch field {
        case .Box, .OccupiedDropzone:
            return BoxNode(color: UIColor.yellowColor(), size: size)
        case .FreeDropzone:
            return DropzoneNode(color: UIColor.redColor(), size: size)
        case .Wall:
            return WallNode(color: UIColor.blueColor(), size: size)
        default:
            return nil
        }
    }
    
    private func zIndexForField(field: Field) -> CGFloat {
        switch field {
        case .Box, .OccupiedDropzone:
            return 2
        case .FreeDropzone:
            return 1
        case .Wall:
            return 3
        default:
            return 0
        }
        
    }
}
