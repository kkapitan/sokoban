//
//  Page.swift
//  TimeCell
//
//  Created by Krzysztof Kapitan on 29.08.2016.
//  Copyright © 2016 AppUnite. All rights reserved.
//

import Foundation

struct Page {
    let index: Int
    let count: Int
    
    func nextPage() -> Page {
        return Page(index: index + 1, count: count)
    }
}