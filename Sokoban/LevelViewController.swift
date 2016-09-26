//
//  LevelViewController.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 18.09.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import UIKit

class LevelViewController : UIViewController {
    var levelData: LevelData!
    
    let embedGameControllerSegue = "GameControllerEmbedSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let gameViewController = segue.destinationViewController as? GameViewController
            where segue.identifier == embedGameControllerSegue else {
            return
        }
        
        gameViewController.levelData = levelData
        gameViewController.gameViewModel.delegate = self
        
    }
}

extension LevelViewController : ViewControllerIdentificable {}

extension LevelViewController : GameViewModelDelegate {
    
    func gameViewModel(_: GameViewModel, didWinLevelWithMark mark: Int) {
        let levelCompletedViewController = MainWireframe().levelCompletedViewController()
        
        levelCompletedViewController.backToMenuAction = { [weak self] in
            guard let sself = self else { return }
            
            sself.dismissViewControllerAnimated(false, completion: nil)
        }
        
        levelCompletedViewController.nextLevelAction = { [weak self] in
            guard let sself = self else { return }
            
            let currentLevelNumber = sself.levelData.id
            let nextLevelNumber = currentLevelNumber + 1
            
            let nextLevelData = LevelReader().readLevelData(nextLevelNumber)
            
            let levelViewController = MainWireframe().levelViewController()
            levelViewController.levelData = nextLevelData
            
            guard let presentingViewController = sself.presentingViewController else { return }
            
            presentingViewController.dismissViewControllerAnimated(false, completion: {
                presentingViewController.presentViewController(levelViewController, animated: true, completion:nil)
            })
        }
        
        levelCompletedViewController.repeatLevelAction = { [weak self] in
            guard let sself = self else { return }
            
            let levelViewController = MainWireframe().levelViewController()
            levelViewController.levelData = sself.levelData
            
            guard let presentingViewController = sself.presentingViewController else { return }
            
            presentingViewController.dismissViewControllerAnimated(false, completion: {
                presentingViewController.presentViewController(levelViewController, animated: true, completion:nil)
            })
        }
        
        levelCompletedViewController.modalPresentationStyle = .Custom
        presentViewController(levelCompletedViewController, animated: false, completion: nil)
    }
    
    func gameViewModel(_: GameViewModel, didUpdateMovementCount count: Int) {
    }
}