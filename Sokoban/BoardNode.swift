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
    private(set) var nodeSize: CGSize = CGSizeZero
    
    var scaledSize : CGSize {
        return CGSizeMake(nodeSize.width * xScale, nodeSize.height * yScale)
    }
    
    init?(level: Level) {
        super.init()
        let pointAdapter = GridPointToCGPointAdapter(board: level.board)
        
        nodeSize = CGSizeMake(tileSize * CGFloat(level.board.width), tileSize * CGFloat(level.board.height))
        
        for (y, row) in level.board.grid.enumerate() {
            for (x, field) in row.enumerate() {
                
                let gridPoint = GridPoint(x: x, y: y)
                
                guard let position = pointAdapter.adapt(gridPoint) else { return nil }
                
                if let spriteNodes = spriteNodesForField(field) {
                    for spriteNode in spriteNodes {
                        spriteNode.position = position
                        addChild(spriteNode)
                    }
                }
            }
        }
        
        guard let heroPoint = pointAdapter.adapt(level.hero.position) else { return nil }
        
        let heroNode = HeroNode(color: UIColor.greenColor(), size: size)
        heroNode.name = NodeIdentifiers.HeroIdentifier.name
        heroNode.position = heroPoint
        heroNode.zPosition = 5
        
        addChild(heroNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension BoardNode {
    private func spriteNodesForField(field: Field) -> [SKSpriteNode]? {
        switch field {
        case .Box, .OccupiedDropzone:
            return [BoxNode(), EmptyNode()]
        case .FreeDropzone:
            return [DropzoneNode()]
        case .Wall:
            return [WallNode()]
        case .Empty, .Hero:
            return [EmptyNode()]
        default:
            return nil
        }
    }
}
