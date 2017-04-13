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
        guard let arr = NSArray(contentsOfFile: path) as? [[String: AnyObject]] else { return }
        for item in arr {
            restaurants.append(Restaurant(dict: item))
        }
    }

    // MARK: - Table View Methods  *********************************************************************************

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
        cell.accessoryType = item.isVisited ? .checkmark : .none
        return cell
    }

    // Handles table cell selection
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var elItem = restaurants[indexPath.row]
        let optMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optMenu.addAction(cancelAction)

        let titleStr = "Call 123-0000-\(indexPath.row)"
        let callAct = UIAlertAction(title: titleStr, style: .default, handler: { [weak self] action -> Void in
            let msg = "Sorry, the call feature is not available yet."
            let alertMsg = UIAlertController(title: "Service Unavailable", message: msg, preferredStyle: .alert)
            let okAct = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertMsg.addAction(okAct)
            self?.present(alertMsg, animated: true, completion: nil)
        })
        optMenu.addAction(callAct)

        var checkTitle = "Check In"
        if elItem.isVisited { checkTitle = "Undo Check In" }
        let checkAct = UIAlertAction(title: checkTitle, style: .default, handler: { [weak self] action -> Void in
            elItem.isVisited = !elItem.isVisited
            self?.restaurants[indexPath.row] = elItem
            tableView.reloadRows(at: [indexPath], with: .top)
        })
        optMenu.addAction(checkAct)

        // Show the menu
        present(optMenu, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: false)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            restaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        // Social Sharing Button
        let shareAct = UITableViewRowAction(style: .normal, title: "Share", handler: { [weak self] act, indexPath in
            guard self != nil else { return }
            let defaultText = "Just checking in at " + self!.restaurants[indexPath.row].name
            if let imageToShare = UIImage(named: self!.restaurants[indexPath.row].name) {
                let actController = UIActivityViewController(activityItems: [defaultText, imageToShare],
                                                             applicationActivities: nil)
                self!.present(actController, animated: true, completion: nil)
            }
        })
        shareAct.backgroundColor = UIColor(red: 0.0, green: 147.0/255.0, blue: 227.0/255.0, alpha: 1.0)

        // Delete Button
        let deleteAct = UITableViewRowAction(style: .destructive, title: "Delete", handler: {[weak self] act, indexPath in
            self?.restaurants.remove(at: indexPath.row)
            self?.tableView.deleteRows(at: [indexPath], with: .fade)
        })

        return [shareAct, deleteAct]
    }
}
