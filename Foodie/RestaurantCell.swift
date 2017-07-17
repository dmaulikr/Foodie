//
//  RestaurantCell.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 12/04/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!

    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.bounds.height / 2
    }
}
