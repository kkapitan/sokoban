//
//  Wireframes.swift
//  TimeCell
//
//  Created by Krzysztof Kapitan on 22.07.2016.
//  Copyright © 2016 AppUnite. All rights reserved.
//

import UIKit


protocol Wireframe {
    var storyboardName: String { get }
}

extension Wireframe {
    var storyboard : UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: nil)
    }
}

protocol ViewControllerIdentificable {
    static var storyboardId: String { get }
}

extension ViewControllerIdentificable where Self: UIViewController {
    static var storyboardId: String {
        let name = NSStringFromClass(Self)
        return name.componentsSeparatedByString(".").last!
    }
}


struct Initiatior<T: UIViewController> {
    let storyboard: UIStoryboard
    
    func instantiate<T: ViewControllerIdentificable>() -> T? {
        guard let viewController = storyboard.instantiateViewControllerWithIdentifier(T.storyboardId) as? T else { return nil }
        
        return viewController
    }
    
    func instantiateInitial() -> T? {
        guard let viewController = storyboard.instantiateInitialViewController() as? T else { return nil }
        
        return viewController
    }
}

struct MainWireframe : Wireframe {
    let storyboardName = "Main"
    
    func levelViewController() -> LevelViewController {
        return Initiatior<LevelViewController>(storyboard: storyboard).instantiate()!
    }
    
    func levelDetailsViewController() -> LevelDetailsViewController {
        return Initiatior<LevelDetailsViewController>(storyboard: storyboard).instantiate()!
    }
    
    func levelCompletedViewController() -> LevelCompletedViewController {
        return Initiatior<LevelCompletedViewController>(storyboard: storyboard).instantiate()!
    }
}