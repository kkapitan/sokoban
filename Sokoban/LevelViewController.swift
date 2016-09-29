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
    weak var gameViewController: GameViewController!
    
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var levelNameLabel: UILabel!
    @IBOutlet weak var bestLabel: UILabel!
    
    let embedGameControllerSegue = "GameControllerEmbedSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateViews()
    }
    
    @IBAction func backToMenuAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func resetLevelAction(sender: AnyObject) {
        populateViews()
        
        gameViewController.view.removeFromSuperview()
        gameViewController.removeFromParentViewController()
        performSegueWithIdentifier(embedGameControllerSegue, sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let gameViewController = segue.destinationViewController as? GameViewController
            where segue.identifier == embedGameControllerSegue else {
            return
        }
        
        gameViewController.levelData = levelData
        gameViewController.gameViewModel.delegate = self
        
        self.gameViewController = gameViewController
    }
    
    func updateBestLabel(best: Int?) {
        if let best = best {
            bestLabel.text = "Best: \(best)"
        } else {
            bestLabel.text = "Best: ----"
        }
    }
    
    func updateMovesLabel(moves: Int) {
        movesLabel.text = "Moves: \(moves)"
    }
    
    func populateViews() {
        let best = NSUserDefaults.standardUserDefaults().getBest(levelData)
        updateBestLabel(best)
        
        updateMovesLabel(0)
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
        
        levelCompletedViewController.mark = mark
        
        levelCompletedViewController.modalPresentationStyle = .Custom
        presentViewController(levelCompletedViewController, animated: false, completion: nil)
    }
    
    func gameViewModel(_: GameViewModel, didUpdateMovementCount count: Int) {
        updateMovesLabel(count)
    }
}