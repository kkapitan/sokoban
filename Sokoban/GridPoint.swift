//
//  GridPoint.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 01.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import Foundation

struct GridPoint {
    let x: Int
    let y: Int
}

func ==(lhs: GridPoint, rhs: GridPoint) -> Bool { return lhs.x == rhs.x && lhs.y == rhs.y }
extension GridPoint : Equatable {}

extension GridPoint : Hashable {
    /* Apply Cantor Pairing Function pi(k1, k2) = 1/2(k1 + k2)(k1 + k2 + 1) + k2 which is bijection N x N -> N
       Since it might be possible for GridPoint coordinate to reach negative value, at first apply simple bijection Z -> N */
    
    var hashValue: Int {
        let hashX = self.x < 0 ? ( -self.x * 2 - 1) : 2 * self.x
        let hashY = self.y < 0 ? ( -self.y * 2 - 1) : 2 * self.y
        
        return (hashX + hashY) * (hashX + hashY + 1) / 2 + hashY
    }
}

extension GridPoint : CustomStringConvertible {
    var description: String {
        return "(\(self.x),\(self.y))"
    }
}