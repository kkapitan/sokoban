//
//  LevelCompletedViewController.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 11.09.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import UIKit

class LevelCompletedViewController : UIViewController {
    
    @IBOutlet weak var backToMenuButton: UIButton!
    @IBOutlet weak var repeatLevelButton: UIButton!
    @IBOutlet weak var nextLevelButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popupView: MarkView!
    
    var mark: Int = 3
    
    typealias LevelCompletedAction = () -> ()
    
    var nextLevelAction: LevelCompletedAction?
    var repeatLevelAction: LevelCompletedAction?
    var backToMenuAction: LevelCompletedAction?
    
    var buttons: [UIButton] {
        return [nextLevelButton, repeatLevelButton, backToMenuButton]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        animate()
        
        popupView.setMark(mark, animated: true)
    }
}

extension LevelCompletedViewController {
    
    private func setupViews() {
        popupView.alpha = 0.0
        titleLabel.rotate(-10)
        titleLabel.makeShadow(offset: CGSizeMake(0, 5))
        
        popupView.roundCorners(20.0)
        popupView.addBorder(UIColor.levelCompletedBorderColor(), width: 1)
        popupView.makeShadow(offset: CGSizeMake(-6, 5))
        
        for button in buttons {
            button.addBorder(UIColor.levelCompletedBorderColor(), width: 1)
            button.makeShadow(offset: CGSizeMake(0, 5))
            button.roundCorners(20.0)
            
            button.alpha = 0.0
        }
        
        nextLevelButton.addTarget(self, action: #selector(nextAction), forControlEvents: .TouchUpInside)
        
        backToMenuButton.addTarget(self, action: #selector(menuAction), forControlEvents: .TouchUpInside)

        
        repeatLevelButton.addTarget(self, action: #selector(repeatAction), forControlEvents: .TouchUpInside)
    }
    
    private func animate() {
        popupView.showAsPopup { [weak self] in
            self?.animateButtons()
        }
    }
    
    private func animateButtons() {
        animateButton(0)
    }
    
    private func animateButton(index: Int) {
        guard let button = buttons[safe: index] else { return }
        
        button.fadeIn { [weak self] in
            self?.animateButton(index + 1)
        }
    }
    
    @IBAction func nextAction() {
        dismissViewControllerAnimated(true, completion: nil)
        nextLevelAction?()
    }
    
    @IBAction func repeatAction() {
        dismissViewControllerAnimated(true, completion: nil)
        repeatLevelAction?()
    }
    
    @IBAction func menuAction() {
        dismissViewControllerAnimated(true, completion: nil)
        backToMenuAction?()
    }
}

extension LevelCompletedViewController : ViewControllerIdentificable {}


