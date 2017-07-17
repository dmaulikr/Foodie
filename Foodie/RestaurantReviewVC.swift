//
//  RestaurantReviewVC.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 17/04/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit

class RestaurantReviewVC: UIViewController {

    // MARK: - Properties
    internal var restImage: UIImage!

    // MARK: - Outlets
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var restaurantImageView: UIImageView!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.blurred()
        restaurantImageView.image = restImage
        containerView.transform = CGAffineTransform(translationX: 0.0, y: -1000)
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: { [weak self] in
            self?.containerView.transform = .identity
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
