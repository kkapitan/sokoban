//
//  Provider.swift
//  TimeCell
//
//  Created by Krzysztof Kapitan on 07.07.2016.
//  Copyright © 2016 AppUnite. All rights reserved.
//

import Foundation

class Provider <Element> {
    
    var items: [Element]? = []
    
    typealias ProviderCompletion = (success: Bool, items: [Element]?, error: ErrorType?) -> Void
    
    func loadItems(completion: ProviderCompletion?) {
        fetchItems { [weak self] (success, items, error) in
            if let items = items where success == true {
                self?.items = items
            }
            
            completion?(success: success, items: items, error: error)
        }
        
    }
    
    func fetchItems(completion: ProviderCompletion?) {
        // need to be overrite
    }
    
    func deleteItemAtIndex(index: Int) {
        self.items?.removeAtIndex(index)
    }
}

class PagedProvider <Element> : Provider<Element> {
    var page: Page?
    var limit: Int = 10
    
    var hasMoreData: Bool = true
    var isFetching: Bool = false
    
    typealias PagedProviderCompletion = (success: Bool, items: [Element]?, moreData: Bool, error: ErrorType?) -> Void
    
    override func loadItems(completion: ProviderCompletion?) {
        isFetching = true
        page = Page(index: 1, count: limit)
        
        fetchItems { [weak self] (success, items, more, error) in
            if let items = items where success == true {
                self?.items = items
            }
            
            self?.hasMoreData = more
            self?.isFetching = false
            
            completion?(success: success, items: items, error: error)
        }

    }
    
    func fetchItems(completion: PagedProviderCompletion?) {
        // need to be overrite
    }

    
    func fetchNext(completion: ProviderCompletion?) {
        guard hasMoreData && !isFetching else { return }
        
        isFetching = true
        page = page?.nextPage()
        
        fetchItems { [weak self] (success, items, more, error) in
            if let items = items where success == true {
                self?.items?.appendContentsOf(items)
            }
            
            self?.hasMoreData = more
            self?.isFetching = false
            
            completion?(success: success, items: items, error: error)
        }
    }
    
    
}