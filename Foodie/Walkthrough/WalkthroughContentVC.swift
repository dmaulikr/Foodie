//
//  WalkthroughContentVC.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 14/07/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit

class WalkthroughContentVC: UIViewController {

    // MARK: - Properties
    internal var index = 0
    internal var heading = ""
    internal var imageFile = ""
    internal var content = ""

    // MARK: - Outlets
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet var forwardButton: UIButton!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.currentPage = index
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        switch index {
            case 0...1: forwardButton.setTitle("NEXT", for: .normal)
            case 2: forwardButton.setTitle("DONE", for: .normal)
            default: break
        }
    }

    // MARK: - Actions
    @IBAction func nextButtonTapped(sender: UIButton) {
        switch index {
            case 0...1: // NEXT Button
                let pageViewController = parent as! WalkthroughPageVC
                pageViewController.forward(index: index)
            case 2: // DONE Button
                UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                dismiss(animated: true, completion: nil)
            default: break
        }
    }
}
