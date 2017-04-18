//
//  RestaurantDetailVC.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 13/04/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailVC: UIViewController {

    // MARK: - Properties
    internal var currentRestaurant: Restaurant!

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentRestaurant.name
        imageView.image = UIImage(named: currentRestaurant.name)
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.2)
        tableView.separatorColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 0.8)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        setupMapFooter()
    }

    // MARK: - Actions
    @IBAction func close(segue: UIStoryboardSegue) {
        // Aveda
    }

    @IBAction func ratingButtonTapped(segue: UIStoryboardSegue) {
        if let rating = segue.identifier {
            currentRestaurant.isVisited = true
            switch rating {
                case "great": currentRestaurant.rating = "Absolutely love it! Must try"
                case "good": currentRestaurant.rating = "Good"
                case "dislike": currentRestaurant.rating = "I don't like it"
                default: break
            }
            tableView.reloadData()
        }
    }

    @objc private func showMap() {
        performSegue(withIdentifier: "showMap", sender: nil)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReview" {
            let vc = segue.destination as! RestaurantReviewVC
            vc.restImage = imageView.image
        } else if segue.identifier == "showMap" {
            let vc = segue.destination as! MapVC
            vc.currentRestaurant = currentRestaurant
        }
    }

    // MARK: - Private Methods
    private func setupMapFooter() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showMap))
        mapView.addGestureRecognizer(tapRecognizer)

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(currentRestaurant.location) { [weak self] marks, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            if let placemarks = marks {
                let pmark = placemarks[0]
                let annotation = MKPointAnnotation()
                if let location = pmark.location {
                    annotation.coordinate = location.coordinate
                    self?.mapView.addAnnotation(annotation)
                    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 250, 250)
                    self?.mapView.setRegion(region, animated: false)
                }
            }
        }
    }
}

// MARK: - Table View Methods
extension RestaurantDetailVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! RestaurantDetailCell
        cell.backgroundColor = .clear
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name:"
            cell.valueLabel.text = currentRestaurant.name
        case 1:
            cell.fieldLabel.text = "Type:"
            cell.valueLabel.text = currentRestaurant.type
        case 2:
            cell.fieldLabel.text = "Location:"
            cell.valueLabel.text = currentRestaurant.location
        case 3:
            cell.fieldLabel.text = "Phone:"
            cell.valueLabel.text = currentRestaurant.phone
        case 4:
            cell.fieldLabel.text = "Been Here:"
            if currentRestaurant.isVisited { cell.valueLabel.text = currentRestaurant.rating }
            else { cell.valueLabel.text = "No" }
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        return cell
    }

}























