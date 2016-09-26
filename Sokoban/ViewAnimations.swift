//
//  ViewAnimations.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 11.09.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import UIKit

extension UIView {
    
    func showAsPopup(completion: (() -> ())?) {
        let previousTransform = transform
        
        alpha = 0.0
        transform = CGAffineTransformScale(transform, 0.1, 0.1)
        UIView.animateWithDuration(0.3, animations: { [weak self] in
            self?.alpha = 1.0
            self?.transform = previousTransform
        }, completion: { _ in
            completion?()
        })
    }
    
    func hideAsPopup(completion: (() -> ())?) {
        UIView.animateWithDuration(0.3, animations: { [weak self] in
            guard let sself = self else { return }
            sself.transform = CGAffineTransformScale(sself.transform, 0.1, 0.1)
        }, completion: { _ in
            completion?()
        })
    }

    
    func fadeIn(completion: (() -> ())?) {
        alpha = 0.0
        UIView.animateWithDuration(0.3, animations: { [weak self] in
            self?.alpha = 1.0
            }, completion: { _ in
                completion?()
        })
    }
    
    func fadeOut(completion: (() -> ())?) {
        alpha = 1.0
        UIView.animateWithDuration(0.3, animations: { [weak self] in
            self?.alpha = 0.0
            }, completion: { _ in
                completion?()
        })
    }
}
