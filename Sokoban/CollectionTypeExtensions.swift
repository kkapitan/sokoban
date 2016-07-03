//
//  CollectionTypeExtensions.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 01.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

extension CollectionType {
    subscript(safe index: Index) -> Generator.Element? {
        guard self.indices.contains(index) else { return nil }
        
        return self[index]
    }
}