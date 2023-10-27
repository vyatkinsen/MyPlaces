//
//  MapViewController.swift
//  MyPlaces
//
//  Created by Арсений Вяткин on 27.10.2023.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var place: Place!

    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func closeVC() {
        dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlaceMark()
    }

    private func setupPlaceMark() {
        guard let location = place.location else { return }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            guard let placemarks = placemarks else { return }
            
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = self.place.name
            annotation.subtitle = self.place.type
            guard let placemarkLocation = placemark?.location else { return }
            
            annotation.coordinate = placemarkLocation.coordinate
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
 
}
