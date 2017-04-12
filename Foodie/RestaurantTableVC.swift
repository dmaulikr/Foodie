//
//  RestaurantTableVC.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 12/04/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit

class RestaurantTableVC: UITableViewController {

    // MARK: - Properties
    private var restaurants: [Restaurant] = []

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Private Methods
    private func loadData() {
        guard let path = Bundle.main.path(forResource: "RestaurantsData", ofType: "plist") else { return }
        guard let arr = NSArray(contentsOfFile: path) as? [[String: String]] else { return }
        for item in arr {
            restaurants.append(Restaurant(dict: item))
        }
    }

    // MARK: - Table view data source *********************************************************************************

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
        let item = restaurants[indexPath.row]
        cell.nameLabel.text = item.name
        cell.locationLabel.text = item.location
        cell.typeLabel.text = item.type
        cell.thumbnailImageView.image = UIImage(named: item.name)
        return cell
    }
}
