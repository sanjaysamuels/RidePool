//
//  ProviderTrackingViewController.swift
//  Seeker2
//
//  Created by user206596 on 8/14/22.
//

import UIKit
import Firebase
import CoreLocation
import MapKit
import FirebaseFirestore

class ProviderTrackingViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private var locationManager : CLLocationManager!
       
    @Published var driverInfo = [DriverInfo]()
       
    private var db = Firestore.firestore()
    let database = Firestore.firestore()

       
       private var driverAnnotation : MKPointAnnotation?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
    
    self.mapView.delegate = self
    mapView.showsUserLocation = true
    
    locationManager = CLLocationManager()
    locationManager.delegate = self
    
    locationManager.requestAlwaysAuthorization()
    
    locationManager.startUpdatingLocation()
    
    driverAnnotation = MKPointAnnotation()
    
        var docRef: DocumentReference! = nil
   docRef = db.collection("ios_seeker").document("rideTracking")
    docRef.getDocument{[self] (docsnapshot,error) in
                       
        guard let docSnapshot = docsnapshot else{return}
        guard let data = docSnapshot.data() else{return}
        
        if let coordinates = data["coordinates"] as? [String: Any]{
            let latitude = coordinates["latitude"] as? Double ?? 0.0
            
            let longitude = coordinates["longitude"] as? Double ?? 0.0
           // let longitude = data["longitude"] as? CLLocationDegrees ?? 0.0
            
            print("dbdata--",coordinates)
            
            let cordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                       self.setLocation(currentDriverPoints: cordinate)
        }
       
        
     }
    
    }

   
private var isDriverMarkerSet = false

private func setLocation(currentDriverPoints : CLLocationCoordinate2D){
    print("location : \(currentDriverPoints.latitude), \(currentDriverPoints.longitude)")
    if !isDriverMarkerSet {
        driverAnnotation?.coordinate = currentDriverPoints
        isDriverMarkerSet = true
        mapView.addAnnotation(driverAnnotation!)
        
        let destination = MKPointAnnotation()
        destination.title = "Destination-543, Edenvalley"
        destination.coordinate = CLLocationCoordinate2D(latitude: 43.440202, longitude: -80.564848)
        mapView.addAnnotation(destination)
             
    } else {
        let angle = angleFromCoordinate(firstCoordinate: driverAnnotation!.coordinate, secondCoordinate: currentDriverPoints)
        
        UIView.animate(withDuration: 2) {
            self.driverAnnotation?.coordinate = currentDriverPoints
        }
        
        //Getting the MKAnnotationView
        let annotationView = self.mapView.view(for: driverAnnotation!)
        
        //Angle for moving the driver
        UIView.animate(withDuration: 1) {
            annotationView?.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        }
        
    }
    
    
    self.zoomOnAnnotation()
}

private func zoomOnAnnotation(){
    let region = MKCoordinateRegion(center: driverAnnotation!.coordinate, latitudinalMeters: 100, longitudinalMeters: 100)
    mapView.setRegion(region, animated: true)
}

func angleFromCoordinate(firstCoordinate: CLLocationCoordinate2D,
                         secondCoordinate: CLLocationCoordinate2D) -> Double {
                             
                             let deltaLongitude: Double = secondCoordinate.longitude - firstCoordinate.longitude
                             let deltaLatitude: Double = secondCoordinate.latitude - firstCoordinate.latitude
                             let angle = (Double.pi * 0.5) - atan(deltaLatitude / deltaLongitude)
                             
                             if (deltaLongitude > 0) {
                                 return angle
                             } else if (deltaLongitude < 0) {
                                 return angle + Double.pi
                             } else if (deltaLatitude < 0) {
                                 return Double.pi
                             } else {
                                 return 0.0
                             }
                         }
                     }


                  extension ProviderTrackingViewController : CLLocationManagerDelegate {
                      func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                          
                         
                          //zoomOnAnnotation()
 
 if let currentLoaction = manager.location?.coordinate {
     print("current location--",currentLoaction)
     
     
     
  let coordinates = ["latitude": currentLoaction.latitude, "longitude": currentLoaction.longitude]
     
     let dbRef = database.document("ios_seeker/rideTracking")
     
     dbRef.setData(["coordinates" : coordinates])
     
 }
 
}
}
extension ProviderTrackingViewController : MKMapViewDelegate {
func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    if !(annotation is MKPointAnnotation) {
        return nil
    }
    let annotationIdentifier = "AnnotationIdentifier"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier)
    
    if annotationView == nil {
        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
        annotationView!.canShowCallout = true
    }
    else {
        annotationView!.annotation = annotation
    }
    let pinImage = UIImage(named: "ic_driver")
    annotationView!.image = pinImage
    return annotationView
}



func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
    let region = MKCoordinateRegion(center: userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1000, longitudeDelta: 1000))
   // self.mapView.setRegion(region, animated: true)
}
}
