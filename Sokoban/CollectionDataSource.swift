//
//  CollectionTableDataSource.swift
//  TimeCell
//
//  Created by Krzysztof Kapitan on 14.07.2016.
//  Copyright © 2016 AppUnite. All rights reserved.
//

import UIKit


class CollectionDataSource<CellClass: CellType where CellClass: UICollectionViewCell>  : DataSource<CellClass>, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Cell.reuseIdentifier, forIndexPath: indexPath) as! Cell
        
        let dataItems = itemsToPresent()
        let dataItem = dataItems![indexPath.row]
        
        let dataViewModel = ViewModel(model: dataItem)
        
        self.configureCell?(cell: cell, viewModel: dataViewModel)
        
        return cell
    }
    
    override init() {
        super.init()
        provider = Provider<Element>()
    }
    
    override init(provider: Provider<Element>) {
        super.init()
        self.provider = provider
    }
}