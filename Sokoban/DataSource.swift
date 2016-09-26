//
//  DataSource.swift
//  TimeCell
//
//  Created by Krzysztof Kapitan on 04.07.2016.
//  Copyright © 2016 AppUnite. All rights reserved.
//

import Foundation

class DataSource<CellClass: CellType> : NSObject {
    typealias Cell = CellClass
    typealias Element = Cell.ViewModel.Model
    typealias ViewModel = Cell.ViewModel
    
    var provider: Provider<Element>
    
    func itemsToPresent() -> [Cell.ViewModel.Model]? {
        return provider.items
    }
    
    func count() -> Int {
        guard let items = itemsToPresent() else {
            return 0;
        }
        return items.count
    }
    
    typealias ConfigureCellBlock = (cell: Cell, viewModel: Cell.ViewModel) -> ()
    var configureCell: ConfigureCellBlock? = { cell, viewModel in
        cell.populateWithViewModel(viewModel)
    }
    
    
    override init() {
        provider = Provider<Element>()
    }
    
    init(provider: Provider<Element>) {
        self.provider = provider
        super.init()
    }
}

