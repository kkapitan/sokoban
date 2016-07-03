//
//  Adapters.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 01.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

protocol OneSideAdaptable {
    associatedtype FromValue
    associatedtype ToValue
    
    func adapt(from: FromValue) -> ToValue?
}

protocol TwoSideAdaptable : OneSideAdaptable {
    associatedtype FromValue
    associatedtype ToValue
    
    func adapt(from: ToValue) -> FromValue?
}