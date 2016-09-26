//
//  LevelSelectionViewController.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 11.09.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import UIKit

class LevelDataProvider: Provider<LevelData> {
    override func fetchItems(completion: ProviderCompletion?) {
        let resourcePath = NSBundle.mainBundle().resourcePath!
        
        do {
            let levelReader = LevelReader()
            
            let items = try NSFileManager().contentsOfDirectoryAtPath(resourcePath)
            
            let levelNames = items.filter { $0.rangeOfString("level") != nil }
                .flatMap { $0.componentsSeparatedByString(".").first }
            
            let levels = levelNames.flatMap { levelReader.readLevelData($0) }
            
             completion?(success: true, items: levels, error: nil)
        } catch (let e) {
             completion?(success: false, items: nil, error: e)
        }
    }
}

class LevelSelectionViewController : UICollectionViewController {
    let dataSource = CollectionDataSource<LevelSelectionCell>(provider: LevelDataProvider())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDataSource()
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let levelData = dataSource.itemsToPresent()?[safe: indexPath.row] else { return }
        
        let levelDetailsViewController = MainWireframe().levelDetailsViewController()
        levelDetailsViewController.modalPresentationStyle = .Custom
        levelDetailsViewController.levelData = levelData
        levelDetailsViewController.startLevelAction = { [weak self] in
            
            let levelViewController = MainWireframe().levelViewController()
            levelViewController.levelData = levelData
            
            self?.presentViewController(levelViewController, animated: true, completion: nil)
        }
        
        presentViewController(levelDetailsViewController, animated: true, completion: nil)
    }
}

extension LevelSelectionViewController {
    
    private func setupViews() {
        collectionView?.dataSource = dataSource
    }
    
    private func setupDataSource() {
        dataSource.provider.loadItems { [weak self] (success, items, error) in
            if (success) {
                self?.collectionView?.reloadData()
            }
        }
    }
}