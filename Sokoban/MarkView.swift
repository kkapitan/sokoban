//
//  MarkView.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 21.09.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import UIKit

extension NSUserDefaults {
    
    func registerMark(mark: Int, level: LevelData) {
        guard getMark(level) < mark else { return }
        
        let key = keyForLevel(level)
        setObject(mark, forKey: key)
    }
    
    func getMark(level: LevelData) -> Int {
        let key = keyForLevel(level)
        
        return objectForKey(key) as? Int ?? 0
    }
    
    private func keyForLevel(level: LevelData) -> String {
        return "sokoban-mark-key-level-\(level.id)"
    }
}

class MarkView : UIView {
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    
    var markedImage: UIImage = UIImage(named: "marked_image")!
    var unmarkedImage: UIImage = UIImage(named: "unmarked_image")!
    
    var markImageViews: [UIImageView] {
        return [firstImageView, secondImageView, thirdImageView]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetMark()
    }
    
    func setMark(mark: Int, animated: Bool) {
        resetMark()
        
        let mark = min(max(0, mark), 3)
        _setMark(mark, index:0,  animated: animated)
    }
    
    private func _setMark(mark:Int, index: Int, animated: Bool) {
        guard index < mark else { return }
        
        let imageView = markImageViews[index]
        
        let block = { [weak self] in
            imageView.image = self?.markedImage
            
            self?._setMark(mark, index: index + 1, animated: animated)
        }
        
        animated ? animate(imageView, completion: block) : block()
    }
    
    private func resetMark() {
        markImageViews.forEach( { $0.image = unmarkedImage } )
    }
    
    private func animate(imageView: UIImageView, completion: () -> ()) {
        
        let animatedImageView = UIImageView(frame: imageView.frame)
        animatedImageView.image = markedImage
        
        animatedImageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1)
        
        addSubview(animatedImageView)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: { 
            animatedImageView.transform = CGAffineTransformIdentity
        }) { (finished) in
            animatedImageView.removeFromSuperview()
            completion()
        }
    }
}