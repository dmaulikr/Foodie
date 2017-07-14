//
//  WalkthroughPageVC.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 14/07/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit

class WalkthroughPageVC: UIPageViewController {

    // MARK: - Properties
    private let pageHeadings = ["Personalize", "Locate", "Discover"]
    private let pageImages = ["foodpin-intro-1", "foodpin-intro-2", "foodpin-intro-3"]
    private let pageContent = [
        "Pin your favorite restaurants and create your own foodguide",
        "Search and locate your favourite restaurant on Maps",
        "Find restaurants pinned by your friends and other foodies around the world"
    ]

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        if let startingVC = contentViewController(at: 0) {
            setViewControllers([startingVC], direction: .forward, animated: true, completion: nil)
        }
    }

    // MARK: -  Public Methods
    internal func forward(index: Int) {
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    // MARK: - Private Methods
    fileprivate func contentViewController(at index: Int) -> WalkthroughContentVC? {
        if index < 0 || index >= pageHeadings.count { return nil }

        if let pageVC = storyboard?.instantiateViewController(withIdentifier: "WalkthroughContentVC") as? WalkthroughContentVC {
            pageVC.imageFile = pageImages[index]
            pageVC.heading = pageHeadings[index]
            pageVC.content = pageContent[index]
            pageVC.index = index
            return pageVC
        }
        return nil
    }
}

// MARK: - Page View Data Source Methods
extension WalkthroughPageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentVC).index
        index -= 1
        return contentViewController(at: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalkthroughContentVC).index
        index += 1
        return contentViewController(at: index)
    }
}














