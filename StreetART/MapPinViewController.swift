//
//  MapPinViewController.swift
//  StreetART
//
//  Created by George Allard on 15/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapPinViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var addArt: UIBarButtonItem!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        mapView.userTrackingMode = .follow
        
        let someCoordinate = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = someCoordinate
        mapView.addAnnotation(annotation)

        
}
    
    @IBAction func addArt_TouchUpInside(_ sender: Any) {
        
       
    }
    
    
}
