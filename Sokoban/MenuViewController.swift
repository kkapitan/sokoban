//
//  MenuViewController.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 06.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import UIKit

class MenuViewController : UIViewController {
    
    
    
}

extension MenuViewController : UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MenuViewCell.reuseIdentifier, forIndexPath: indexPath)
        return cell
    }
}

extension MenuViewController : UICollectionViewDelegate {

}
