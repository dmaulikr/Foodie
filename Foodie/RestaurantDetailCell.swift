//
//  RestaurantDetailCell.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 13/04/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit

class RestaurantDetailCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
