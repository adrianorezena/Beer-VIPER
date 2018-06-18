//
//  BeerTableViewCell.swift
//  Beer VIPER
//
//  Created by Adriano on 16/06/2018.
//  Copyright © 2018 Adriano. All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {

    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerTaglineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
