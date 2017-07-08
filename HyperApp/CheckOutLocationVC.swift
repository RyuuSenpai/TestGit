//
//  CheckOutLocationVC.swift
//  HyperApp
//
//  Created by Killvak on 30/06/2017.
//  Copyright © 2017 Killvak. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CheckOutLocationVC: UIViewController ,CLLocationManagerDelegate  ,MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var addressTxt: UITextField!
    @IBOutlet weak var buildingTxt: UITextField!
    @IBOutlet weak var floorTxt: UITextField!
    @IBOutlet weak var apartmentTxt: UITextField!
    @IBOutlet weak var mobileNumTxt: UITextField!
    @IBOutlet weak var landlineTxt: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    let locationManager = CLLocationManager()
    
    var fName = "" {
        didSet {
            self.firstNameTxt?.text = fName
        }
    }
    var lastName = "" {
        didSet {
            self.lastNameTxt?.text = lastName
        }
    }
    
    var userId : String?
    var lat : CLLocationDegrees?
    var long : CLLocationDegrees?
    let requestClass = User_LocationModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = []
        // Do any additional setup after loading the view.
        self.mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        
        
        
        
        
        /*
         // Ask for Authorisation from the User.
         self.locationManager.requestAlwaysAuthorization()
         
         // For use in foreground
         self.locationManager.requestWhenInUseAuthorization()
         
         if CLLocationManager.locationServicesEnabled() {
         locationManager.delegate = self
         locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
         locationManager.startUpdatingLocation()
         }*/
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        print("Updating")
        manager.stopUpdatingLocation()
        lat =  userLocation.coordinate.latitude
        long =  userLocation.coordinate.longitude
        let coordinations = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,longitude: userLocation.coordinate.longitude)
        let span = MKCoordinateSpanMake(0.2,0.2)
        let region = MKCoordinateRegion(center: coordinations, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // your code here
            print("Updating  regionDidChangeAnimated  \(self.mapView.centerCoordinate.latitude, long: self.mapView.centerCoordinate.longitude) ")
            self.lat =  self.mapView?.centerCoordinate.latitude
            self.long =  self.mapView?.centerCoordinate.longitude
            self.setUsersClosestCity()
        }
    }
    
    func setUsersClosestCity()
    {
        guard  let lat = lat , let long = long else { self.navigationController?.popViewController(animated: true); return }
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude:lat, longitude:long)
        geoCoder.reverseGeocodeLocation(location)
        {
            (placemarks, error) -> Void in
            
            let placeArray = placemarks as [CLPlacemark]!
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
            
            // Address dictionary
            print(placeMark.addressDictionary)
            
            var street = ""
            var city = ""
            var mohafza = ""
            var country = ""
            // Location name
            if let locationName = placeMark.addressDictionary?["Name"] as? String
            {
                street = locationName
            }
            
            // Street address
            
            // City
            if let cityy = placeMark.addressDictionary?["City"] as? String
            {
                city = cityy
            }
            
            // Zip code
            if let zip = placeMark.addressDictionary?["State"] as? String
            {
                mohafza = zip
            }
            
            // Country
            if let countryy = placeMark.addressDictionary?["Country"] as? String
            {
                country = countryy
            }
            
            DispatchQueue.main.async {
                
                
                self.addressTxt.text = street + " / " + city + " / " + mohafza + " / " + country
            }
        }
    }
    
    
    @IBAction func sendLocation(_ sender: 	UIButton) {
        guard let id = userId , let address = addressTxt.text , !address.isEmpty , let floor = self.floorTxt.text ,!floor.isEmpty , let buildNum = buildingTxt.text , !buildNum.isEmpty else {
            
            SweetAlert().showAlert("All Data is Required ")
            return }
        
        requestClass.postAddingUserAddress(user_id: id , floor_num: floor, building_num: buildNum , street_name: address, longitude: long, latitude: lat) {
            
            
        }
        
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
