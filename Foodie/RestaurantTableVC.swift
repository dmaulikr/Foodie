//
//  RestaurantTableVC.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 12/04/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableVC: UITableViewController, NSFetchedResultsControllerDelegate {

    // MARK: - Properties
    private var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    private var restaurants: [RestaurantMO] = []

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        title = "Foodie"
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setupCoreData()
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Actions
    @IBAction func unwindToHomeScreen(segue:UIStoryboardSegue) {
        // Banana Banana Banana
    }

    // MARK: - Private Methods
    private func setupCoreData() {
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDel.persistentContainer.viewContext
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context,
                                                           sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        do {
            try fetchResultController.performFetch()
            if let fetchedObjects = fetchResultController.fetchedObjects {
                restaurants = fetchedObjects
                if restaurants.count == 0 { loadSeedData() }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    private func loadSeedData() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let path = Bundle.main.path(forResource: "RestaurantsData", ofType: "plist") else { return }
        guard let arr = NSArray(contentsOfFile: path) as? [[String: AnyObject]] else { return }
        guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
        for item in arr {
            let newRest = RestaurantMO(context: appDel.persistentContainer.viewContext)
            newRest.name = item["name"] as? String
            newRest.type = item["type"] as? String
            newRest.location = item["location"] as? String
            newRest.phone = item["phone"] as? String
            newRest.isVisited = item["isVisited"] as! Bool
            newRest.image = UIImagePNGRepresentation(UIImage(named: item["name"] as! String)!)
            restaurants.append(newRest)
        }
        appDel.saveContext()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        if segue.identifier == "showRestaurantDetail" {
            let vc = segue.destination as! RestaurantDetailVC
            vc.currentRestaurant = restaurants[indexPath.row]
        }
    }

    // MARK: - Table View Methods  *********************************************************************************

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
        let item = restaurants[indexPath.row]
        cell.nameLabel.text = item.name
        cell.locationLabel.text = item.location
        cell.typeLabel.text = item.type
        cell.thumbnailImageView.image = UIImage(data: restaurants[indexPath.row].image!)
        cell.accessoryType = item.isVisited ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { restaurants.remove(at: indexPath.row) }
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        // Social Sharing Button
        let shareAct = UITableViewRowAction(style: .normal, title: "Share", handler: { [weak self] act, indexPath in
            guard self != nil else { return }
            let defaultText = "Just checking in at " + self!.restaurants[indexPath.row].name!
            if let imageToShare = UIImage(data: self!.restaurants[indexPath.row].image!) {
                let actController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                self!.present(actController, animated: true, completion: nil)
            }
        })
        shareAct.backgroundColor = UIColor(red: 0.0, green: 147.0/255.0, blue: 227.0/255.0, alpha: 1.0)

        // Delete Button
        let deleteAct = UITableViewRowAction(style: .default, title: "Delete", handler: { [weak self] act, indexPath in
            guard self != nil else { return }
            guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
            let context = appDel.persistentContainer.viewContext
            let restToDelete = self!.fetchResultController.object(at: indexPath)
            context.delete(restToDelete)
            appDel.saveContext()
        })

        return [shareAct, deleteAct]
    }

    // MARK: - Core Data Methods  *********************************************************************************
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .insert: if let newIndexPath = newIndexPath { tableView.insertRows(at: [newIndexPath], with: .fade) }
            case .delete: if let indexPath = indexPath { tableView.deleteRows(at: [indexPath], with: .fade) }
            case .update: if let indexPath = indexPath { tableView.reloadRows(at: [indexPath], with: .fade) }
            default: tableView.reloadData()
        }
        if let fetchedObjects = controller.fetchedObjects { restaurants = fetchedObjects as! [RestaurantMO] }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}





























