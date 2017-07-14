//
//  DiscoverCell.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 14/07/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit

class DiscoverCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        // Card View
        contentView.layer.cornerRadius = 5.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 5.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3.0)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5.0).cgPath

        // Image View
        let rectShape = CAShapeLayer()
        rectShape.bounds = imageView.frame
        rectShape.position = imageView.center
        rectShape.path = UIBezierPath(roundedRect: imageView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5)).cgPath
        imageView.layer.mask = rectShape
    }
}
