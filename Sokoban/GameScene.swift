//
//  GameScene.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 30.06.2016.
//  Copyright (c) 2016 CappSoft. All rights reserved.
//

import SpriteKit

extension SKScene {
    func scaleToFullyVisibleInBounds(boundsSize: CGSize, defaultSize: CGSize) -> CGFloat {
        return min(1, min(boundsSize.height / defaultSize.height, boundsSize.width / defaultSize.width))
    }
    
    func positionToCenterInSize(boundsSize: CGSize, size: CGSize) -> CGPoint {
        return CGPointMake(boundsSize.width/2 - size.width/2, boundsSize.height/2 - size.height/2)
    }
}

class GameScene: SKScene {
    private(set) var boardNode : BoardNode?
    weak var gameDelegate: GameSceneDelegate?
    
    override func didMoveToView(view: SKView) {
        guard let boardNode = boardNode else { return }
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(scrollAction))
        view.addGestureRecognizer(panGestureRecognizer)
        
        let touchGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        view.addGestureRecognizer(touchGestureRecognizer)
        
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(zoomAction))
        view.addGestureRecognizer(pinchGestureRecognizer)
        
        boardNode.position = positionToCenterInSize(size, size: boardNode.scaledSize)
    }
    
    init(size: CGSize, boardNode: BoardNode) {
        super.init(size: size)
        
        self.boardNode = boardNode
        
        let scaleFactor = scaleToFullyVisibleInBounds(size, defaultSize: boardNode.nodeSize)
        boardNode.setScale(scaleFactor)
        
        self.addChild(boardNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc private func tapAction(sender: UITapGestureRecognizer) {
        guard let boardNode = boardNode else { return }
        
        let touchPoint = sender.locationInView(self.view)
        
        let sceneTouchPoint = self.convertPointFromView(touchPoint)
        let boardTouchPoint = self.convertPoint(sceneTouchPoint, toNode: boardNode)

        let touchedSceneNode = self.nodeAtPoint(sceneTouchPoint)
        let touchedBoardNode = boardNode.nodeAtPoint(boardTouchPoint)
        
        if let _ = touchedSceneNode as? GameScene {
            return
        }
        
        gameDelegate?.boardNode(boardNode, didTouchNode: touchedBoardNode, atPoint: boardTouchPoint)
    }
        
    @objc private func scrollAction(sender: UIPanGestureRecognizer) {
        guard let boardNode = boardNode else { return }
        
        let speedScaleFactor : CGFloat = 0.1
        
        let scaleFactors = (speedScaleFactor, -speedScaleFactor)
        let translation = sender.translationInView(self.view).scaleBy(scaleFactors)
        
        let scaledNodeSize = boardNode.scaledSize
        
        let xMin: CGFloat = 0
        let xMax: CGFloat = max(scaledNodeSize.width - size.width, 0)
        
        let yMin: CGFloat = 0
        let yMax: CGFloat = max(scaledNodeSize.height - size.height,0)
        
        let position = boardNode.position
        
        let x = max(-xMax, min(position.x + translation.x, xMin))
        let y = max(-yMax, min(position.y + translation.y, yMin))
        
        let centerPosition = positionToCenterInSize(size, size:boardNode.nodeSize)
        boardNode.position = CGPointMake(x, y).translateBy(centerPosition)
    }
    
    
    private var maxScaleFactor: CGFloat!
    private var minScaleFactor: CGFloat!
    private var previousScale: CGFloat!
    
    @objc private func zoomAction(sender: UIPinchGestureRecognizer) {
        guard let boardNode = boardNode else { return }
        
        switch sender.state {
        case .Began:
            maxScaleFactor = scaleToFullyVisibleInBounds(size, defaultSize: boardNode.nodeSize)
            minScaleFactor = 1.0
            previousScale = boardNode.xScale
        case .Changed:
            let scaleFactor = sender.scale
            
            let progress = min(max(0,(maxScaleFactor-boardNode.xScale)/(maxScaleFactor-previousScale)),1)
            let position = boardNode.position
            
            let defaultX: CGFloat = 0
            let defaultY: CGFloat = 0
            
            let x = position.x + (defaultX - position.x) * (1-progress)
            let y = position.y + (defaultY - position.y) * (1-progress)
            
            //boardNode.position = CGPointMake(x, y)

            
            boardNode.xScale = min(max(boardNode.xScale * scaleFactor, maxScaleFactor), minScaleFactor)
            boardNode.yScale = min(max(boardNode.yScale * scaleFactor, maxScaleFactor), minScaleFactor)
        default: break
        }
    }
}
