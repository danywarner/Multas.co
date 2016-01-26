//
//  ComparendoCell.swift
//  Comparendos Bogota
//
//  Created by Daniel Warner on 1/25/16.
//  Copyright © 2016 Daniel Warner. All rights reserved.
//

import UIKit

class ComparendoCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(comparendo: Comparendo) {
        descLabel.text = comparendo.description
    }
    
}
