//
//  DiscoverVC.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 14/07/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit

class DiscoverVC: UIViewController {

    // MARK: - Properties
    fileprivate var restaurantsArray: [Restaurant] = []

    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actInd: UIActivityIndicatorView!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Discover"
        actInd.hidesWhenStopped = true

        // Collection View Setup
        let flowLayout = UICollectionViewFlowLayout()
        collectionView.backgroundColor = .groupTableViewBackground
        collectionView.collectionViewLayout = flowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 0.0)
        flowLayout.minimumInteritemSpacing = 2.0
        flowLayout.itemSize = CGSize(width: view.bounds.width - 20.0, height: (view.bounds.width - 20.0) * 0.66)
        populateCollectionView()
    }

    // MARK: - Private Methods
    private func populateCollectionView() {
        actInd.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
            guard let path = Bundle.main.path(forResource: "RestaurantsData", ofType: "plist") else { return }
            guard let arr = NSArray(contentsOfFile: path) as? [[String: AnyObject]] else { return }
            for i in 0...5 { self?.restaurantsArray.append(Restaurant(dict: arr[i])) }
            self?.actInd.stopAnimating()
            self?.collectionView.reloadData()
        })
    }
}

// MARK: - Collection View Methods
extension DiscoverVC: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurantsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "discoverCell", for: indexPath) as! DiscoverCell
        let item = restaurantsArray[indexPath.row]
        cell.imageView.image = UIImage(named: item.name)
        cell.nameLabel.text = item.name
        cell.typeLabel.text = item.type
        cell.locationLabel.text = item.location
        return cell
    }
}
