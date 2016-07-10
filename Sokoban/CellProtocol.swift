//
//  CellProtocol.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 06.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

protocol NibLoadable {
    static var nib: UINib { get }
}

protocol CellType : Reusable, NibLoadable {
    
}

extension NibLoadable where Self : UIView {
    static var nib: UINib {
        return UINib(nibName: NSStringFromClass(Self), bundle: nil)
    }
}

extension Reusable where Self : UICollectionViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(Self)
    }
}