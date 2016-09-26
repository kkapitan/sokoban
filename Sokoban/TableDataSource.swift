//
//  TableDataSource.swift
//  TimeCell
//
//  Created by Krzysztof Kapitan on 14.07.2016.
//  Copyright © 2016 AppUnite. All rights reserved.
//

import UIKit

class TableDataSource<CellClass: CellType where CellClass: UITableViewCell>  : DataSource<CellClass>, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Cell.reuseIdentifier, forIndexPath: indexPath) as! Cell
        
        let dataItems = itemsToPresent()
        let dataItem = dataItems![indexPath.row]
        
        let dataViewModel = ViewModel(model: dataItem)
        
        self.configureCell?(cell: cell, viewModel: dataViewModel)
        
        return cell
    }
    
    override init() {
        super.init()
        provider = Provider<Element>()
    }
    
    override init(provider: Provider<Element>) {
        super.init()
        self.provider = provider
    }
}

