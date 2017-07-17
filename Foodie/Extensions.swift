//
//  Extensions.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 17/04/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit

// Returns the same image but blurred.
extension UIImageView {
    func blurred() {
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurEffectView.frame = self.bounds
        self.addSubview(blurEffectView)
    }
}
