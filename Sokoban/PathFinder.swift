//
//  PathFinder.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 02.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct PathFinder {
    var availableDirections: [Direction] = Direction.allDirections()
    
    let board: Board
    
    /* Run BFS algorithm in order to find path between two nodes in grid */
    
    func pathFrom(from: GridPoint, to: GridPoint) -> [GridPoint]? {
        
        //Initialize dictionary containing parent for each point in BFS tree
        var parent = Dictionary<GridPoint, GridPoint>()
        
        //Initialize array containing points to visit in queue order
        var queue = [from]
        parent[from] = from
        
        //Repeat until queue is empty
        while let point = queue.first {
            queue.removeFirst()
            
            //Try to move in each direction
            for direction in availableDirections {
                let nextPoint = direction.gridPointFollowingDirection(point)
                
                //If field does not exist or movement is not allowed - continue
                guard let field = board[nextPoint] where field.isMovementValid() else {
                    continue
                }
                
                //If field was already visited - continue
                if let _ = parent[nextPoint] {
                    continue
                }
                
                //Set parent of nextPoint as current point and add it to the back of a queue
                parent[nextPoint] = point
                queue.append(nextPoint)
            }
            
            //If path has been found
            if point == to {
                var mutablePoint = to
                var path = [to]
                
                //Reconstruct path by moving upwards BFS tree until reaching the root (parent == self)
                while let parentPoint = parent[mutablePoint] where parentPoint != mutablePoint {
                    path.append(parentPoint)
                    mutablePoint = parentPoint
                }
                
                //Reverse the path to maintain correct order
                return path.reverse()
            }
        }
        
        //If path has not been found return nil
        return nil
    }
    
    init(board: Board, availableDirections: [Direction]? = nil) {
        self.board = board
        if let availableDirections = availableDirections {
            self.availableDirections = availableDirections
        }
    }
}