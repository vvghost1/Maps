//
//  MapViewController.swift
//  task3
//
//  Created by Yura Vorontsov on 22.08.15.
//  Copyright (c) 2015 Yura Vorontsov. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController
{
    var data: Data!

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let location = CLLocation(latitude: data.latitude, longitude: data.longitude)
        let radius: CLLocationDistance = 8000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, radius, radius)
        mapView.setRegion(coordinateRegion, animated: true)
        var objAnnot = MKPointAnnotation()
        let pinLoc = CLLocationCoordinate2DMake(data.latitude, data.longitude)
        objAnnot.coordinate = pinLoc
        objAnnot.title = data.name
        mapView.addAnnotation(objAnnot)
    }
}
