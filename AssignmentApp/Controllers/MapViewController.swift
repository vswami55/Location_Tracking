//
//  MapViewController.swift
//  AssignmentApp
//
//  Created by Virender Swami on 06/04/22.
//

import UIKit
import CoreLocation
import MapKit
import CoreData

class MapViewController: BaseVC, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    var btnTracking: UIBarButtonItem!
    var locationManager: CLLocationManager!
    var lastLocation: CLLocation?

    var appDelegate = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        btnTracking = UIBarButtonItem(title: "Start Location", style: .plain, target: self, action: #selector(didTapToStartTracking))
        btnTracking.tintColor = UIColor.blue
        navigationItem.rightBarButtonItem = btnTracking

        self.title = "Map"
        // Do any additional setup after loading the view.
                

    }
    @objc public func didTapToStartTracking() {
        print("Hello World")
        if btnTracking.title == "Start Location" {
            btnTracking.title = "Stop Location"
            setupMapLocation()
        }else{
            btnTracking.title = "Start Location"
            if CLLocationManager.locationServicesEnabled(){
                    locationManager.stopUpdatingLocation()
                    locationManager.stopMonitoringSignificantLocationChanges()
                }
        }
    }
    // MARK:- SETUP LOCATION MANAGER
    func setupMapLocation() {
        if (CLLocationManager.locationServicesEnabled())
            {
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.distanceFilter = 50
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestAlwaysAuthorization()
            if CLLocationManager.locationServicesEnabled(){
                    locationManager.startUpdatingLocation()
                    locationManager.startMonitoringSignificantLocationChanges()
                }
            }
    }

    
    //insert
    func save(dateTime: String, meters : Int32) {
      
      let person = CoreDatabase.sharedManager.insertRecords(dateTime: dateTime, meters: meters)
      
      if person != nil {
          print("Data saved")
      }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Location Delegate Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let userLocation :CLLocation = locations[0] as CLLocation
        if self.lastLocation != nil {
            let meters: CLLocationDistance = userLocation.distance(from: self.lastLocation!);
            var totalMetersCount = UserDefaults.standard.integer(forKey: "TotalTravelledDistance")

            if meters > 50 {
                let distanceInt = Int(meters)
                totalMetersCount += distanceInt
                UserDefaults.standard.set(totalMetersCount, forKey: "TotalTravelledDistance")
                UserDefaults.standard.synchronize()
                let today = Date()
                let currentDate = today.toString(dateFormat: "dd-MMM-yyyy HH:mm:ss")
                self.save(dateTime: currentDate, meters: Int32(exactly: distanceInt)!)
                self.appDelegate?.scheduleNotification(notificationType: "You have travelled 50 meters.")
            }
        }
//        let today = Date()
//        let currentDate = today.toString(dateFormat: "dd-MMM-yyyy HH:mm:ss")
//        self.save(dateTime: currentDate, meters: Int32(exactly: 30)!)
//        self.appDelegate?.scheduleNotification(notificationType: "You have travelled 50 meters.")

            if let location = locations.last{
                let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                    self.map.setRegion(region, animated: true)
            }
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")

//        self.labelLat.text = "\(userLocation.coordinate.latitude)"
//        self.labelLongi.text = "\(userLocation.coordinate.longitude)"
        
        self.lastLocation = locations.last

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0{
                let placemark = placemarks![0]
                // Drop a pin at user's Current Location
                let place = CustomPin(id: "", title: "\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)", locationName: "\(placemark.country!)", discipline: "", coordinate: userLocation.coordinate, pinTintColor: UIColor.red)
                self.map.addAnnotation(place)
            }
        }

    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    // MARK: - MKMapView Delegate Methods
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Annotation"
        var annotationView: MKAnnotationView? = nil
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
          dequeuedView.annotation = annotation
          annotationView = dequeuedView
        } else {
            annotationView = MKAnnotationView(annotation: annotation,reuseIdentifier: identifier)
            annotationView!.frame = CGRect(x: 0, y: 0, width: 67, height: 26)
            annotationView?.canShowCallout = true
            annotationView?.isUserInteractionEnabled = true
            let pinImage = UIImage(systemName: "mappin.circle")
           let size = CGSize(width: 50, height: 50)
           UIGraphicsBeginImageContext(size)
           pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
           let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            annotationView?.image = resizedImage//UIImage(systemName: "mappin.circle")
        }
        
        return annotationView
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        if view.annotation is MKUserLocation {
            return
        }

        if let annotationTitle = view.annotation?.title
        {
            print("User tapped on annotation with title: \(annotationTitle!)")
        }
    }
}
