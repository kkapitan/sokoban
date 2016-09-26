//
//  LevelDetailsViewController.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 11.09.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import UIKit

class LevelDetailsViewController : UIViewController {
    
    @IBOutlet weak var overlayView: MarkView!
    
    var levelData: LevelData!
    
    typealias LevelDetailsAction = () -> ()
    var startLevelAction: LevelDetailsAction?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        populateViews()
    }
    
    @IBAction func tapAction(sender: UITapGestureRecognizer) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func startAction(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
        
        startLevelAction?()
    }
}

extension LevelDetailsViewController {
    private func setupViews() {
        overlayView.addBorder(UIColor.levelCompletedBorderColor(), width: 1.0)
    }
    
    private func populateViews() {
        let mark = NSUserDefaults.standardUserDefaults().getMark(levelData)
        
        overlayView.setMark(mark, animated: true)
    }
}

extension LevelDetailsViewController : ViewControllerIdentificable {}