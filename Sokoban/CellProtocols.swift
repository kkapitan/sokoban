//
//  NibLoadable.swift
//  TimeCell
//
//  Created by Krzysztof Kapitan on 07.07.2016.
//  Copyright © 2016 AppUnite. All rights reserved.
//

import Foundation
import UIKit


protocol NibLoadable {
    static var nibName: String { get }
}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(Self)
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    static func view() -> Self? {
        return NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil).first as? Self
    }
}

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UITableViewCell {
    
    static var reuseIdentifier: String {
        let name = NSStringFromClass(Self)
        return name.componentsSeparatedByString(".").last!
    }
}

extension Reusable where Self: UICollectionViewCell {
    
    static var reuseIdentifier: String {
        let name = NSStringFromClass(Self)
        return name.componentsSeparatedByString(".").last!
    }
}

extension Reusable where Self: UICollectionReusableView {
    
    static var reuseIdentifier: String {
        let name = NSStringFromClass(Self)
        return name.componentsSeparatedByString(".").last!
    }
}


protocol CellViewModelType {
    associatedtype Model
    
    init(model: Model)
}

protocol CellType : Reusable {
    associatedtype ViewModel : CellViewModelType
    
    func populateWithViewModel(viewmodel: ViewModel);
}

