//
//  MenuViewCell.swift
//  Sokoban
//
//  Created by Krzysztof Kapitan on 06.07.2016.
//  Copyright © 2016 CappSoft. All rights reserved.
//

import UIKit

class MenuViewCell : UICollectionViewCell {
    
    @IBOutlet weak var menuImageView: UIImageView!
    
    @IBOutlet weak var menuTitleLabel: UILabel!
    func populateWithViewModel(viewModel: MenuItemViewModel) {
        
    }
}

//extension MenuViewCell : CellType {}
