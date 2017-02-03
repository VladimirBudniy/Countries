//
//  DetailView.swift
//  Countries
//
//  Created by Vladimir Budniy on 1/19/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit
import MapKit

class DetailView: UIView, MKMapViewDelegate {
    @IBOutlet var countryName: UILabel?
    @IBOutlet var capitalCity: UILabel?
    @IBOutlet var region: UILabel?
    @IBOutlet var population: UILabel?
    @IBOutlet var nativeName: UILabel?
    @IBOutlet var currencies: UILabel?
    @IBOutlet var coordinates: UILabel?
    @IBOutlet var languages: UILabel?
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet var map: MKMapView?
    
    // MARK: protocol MKMapViewDelegate
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        self.removeSpinnerView()
    }
    
    // MARK: - Public
    
    public func fillWithCountry(country: Country) {
        self.loadMapLocation(for: country)
        
        self.countryName?.text = country.countryName
        self.capitalCity?.text = country.capitalCity
        self.region?.text = country.regionName
        self.population?.text = country.populationQty.stringFormatedWithSepator + " ppl"
        self.nativeName?.text = country.nativeName
        self.currencies?.text = country.currencies
        self.coordinates?.text = country.latitude! + ", " + country.longitude!
        self.languages?.text = country.languages
    }
    
    public func loadMapLocation(for country: Country?) {
        self.map?.delegate = self
        
        let latitude = country?.latitude?.doubleValue()
        let longitude = country?.longitude?.doubleValue()
        let coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
        let location = CLLocationDistance(100000)
        let region = MKCoordinateRegionMakeWithDistance(coordinate, location, location)
        self.map?.setRegion(region, animated: true)
     
        
        let annotation = Annotation(coordinate: coordinate,
                                    title: country?.countryName,
                                    subtitle: country?.capitalCity)
        self.map?.addAnnotation(annotation)
    }
    
    public func showSpinner() {
        let spinner = self.spinner
        spinner?.hidesWhenStopped = true
        spinner?.startAnimating()
        
        UIView.animate(withDuration: 1.0, animations: {
            self.loadingView?.alpha = 0.8
        })
    }
    
    public func removeSpinnerView() {
        let spinner = self.spinner
        
        UIView.animate(withDuration: 1.0, animations: {
            self.loadingView?.alpha = 0
        }, completion: { loaded in
            if loaded {
                spinner?.stopAnimating()
            }
        })
    }
}
