//
//  MapVC.swift
//  Foodie
//
//  Created by Eduardo Pacheco on 18/04/17.
//  Copyright © 2017 Eduardo Pacheco. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    // MARK: - Properties
    internal var currentRestaurant: Restaurant!

    // MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = currentRestaurant.name
        setupMapView()
    }

    // MARK: - Private Methods
    private func setupMapView() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(currentRestaurant.location) { [weak self] marks, error in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            if let placemarks = marks {
                let pmark = placemarks[0]
                let annotation = MKPointAnnotation()
                annotation.title = self?.currentRestaurant.name
                annotation.subtitle = self?.currentRestaurant.type
                if let location = pmark.location {
                    annotation.coordinate = location.coordinate
                    self?.mapView.showAnnotations([annotation], animated: true)
                    self?.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        }
    }
}

// MARK: - Map View Delegate
extension MapVC: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let aidi = "RestaurantPin"
        if annotation.isKind(of: MKUserLocation.self) { return nil }

        // Reuse the annotation if possible.
        var annotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: aidi) as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: aidi)
            annotationView?.canShowCallout = true
        }

        let leftIconView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 53.0, height: 53.0))
        leftIconView.image = UIImage(named: currentRestaurant.name)
        leftIconView.contentMode = .scaleAspectFill
        annotationView?.leftCalloutAccessoryView = leftIconView
        return annotationView
    }
}
















