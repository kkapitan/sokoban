//
//  LevelSelectionCell.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 11.09.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import UIKit

class LevelSelectionCell : UICollectionViewCell, CellType {
    typealias ViewModel = LevelSelectionCellViewModel
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func populateWithViewModel(viewmodel: ViewModel) {
        titleLabel.text = viewmodel.numberString
    }
}

struct LevelSelectionCellViewModel : CellViewModelType {
    let numberString: String
    
    typealias Model = LevelData
    
    init(model: Model) {
        numberString = "\(model.id)"
    }
}