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
    fileprivate var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster",
                                       "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate",
                                       "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf",
                                       "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak",
                                       "CASK Pub and Kitchen"]


    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source *********************************************************************************

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath)
        let name = restaurantNames[indexPath.row]
        cell.textLabel?.text = name
        cell.imageView?.image = UIImage(named: name)
        return cell
    }
}
