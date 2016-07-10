//
//  MenuFlowLayout.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 06.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import UIKit

class MenuFlowLayout : UICollectionViewFlowLayout {
    
    enum CellFlowPosition : Int {
        case Before = 0, Current, After
        
        init(indexPath: NSIndexPath) {
            switch indexPath.row {
            case 0: self = .Before
            case 2: self = .After
            default: self = .Current
            }
        }
    }

    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return [0,1,2].flatMap {
            layoutAttributesForItemAtIndexPath( NSIndexPath(forItem: $0, inSection:0) )
        }
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = self.layoutAttributesForItemAtIndexPath(indexPath) else { return nil }
        
        guard let collectionView = self.collectionView else { return nil }
        
        let flowPosition = CellFlowPosition(indexPath: indexPath)
        if flowPosition == .Current {
            attributes.center = CGPointMake(collectionView.frame.midX, collectionView.frame.midY)
        } else if flowPosition == .Before {
            attributes.center = CGPointMake(collectionView.frame.minX, collectionView.frame.midY)
        } else {
            attributes.center = CGPointMake(collectionView.frame.maxX, collectionView.frame.midY)
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}