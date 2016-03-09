//: [Previous](@previous)
import MapKit
import XCPlayground

postfix operator ° {}
postfix func °(degrees: Double) -> Double {return degrees * M_PI / 180.0}

infix operator ** { associativity left precedence 170 }

public func ** (num: Double, power: Double) -> Double{
  return pow(num, power)
}

XCPlaygroundPage.currentPage.needsIndefiniteExecution

let mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))

XCPlaygroundPage.currentPage.liveView = mapView

class Coordinate: NSObject, MKAnnotation {
  
  @objc let coordinate: CLLocationCoordinate2D
  var title: String?
  
  init(place: CLPlacemark) {
    self.coordinate = place.location!.coordinate
  }
  
  init(latitude: CGFloat, longitude: CGFloat) {
    let dLat = CLLocationDegrees(latitude),
    dLon = CLLocationDegrees(longitude)
    self.coordinate = CLLocationCoordinate2D(latitude: dLat, longitude: dLon)
  }
  
  func distanceFrom(other: Coordinate) -> Double {
    let EarthRadius = 6373.0
    let (dLat, dLon) = (coordinate.latitude - other.coordinate.latitude,
                        self.coordinate.longitude - other.coordinate.longitude)
    let (sqSinLat, sqSinLon) = (sin(dLat° / 2.0) ** 2, sin(dLon° / 2.0) ** 2)
    let α = sqSinLat + sqSinLon * cos(coordinate.latitude°) * cos(other.coordinate.latitude°)
    return 2.0 * EarthRadius * atan2(sqrt(α), sqrt(1.0 - α))
  }

}

let geoCoder = CLGeocoder()
let locationDom = Coordinate(latitude: 50.941302, longitude: 6.957189)

let numberFormatter = NSNumberFormatter()
numberFormatter.numberStyle = .DecimalStyle

geoCoder.geocodeAddressString("Kammer Straße, Quadrath Ichendorf") { (placemarks, error) in
  if let placemark = placemarks?.first {
    let annotation = Coordinate(place: placemark)
    let distance = locationDom.distanceFrom(annotation)
    let title = numberFormatter.stringFromNumber(distance)! + " km from Dom"
    annotation.title = title
    mapView.addAnnotation(annotation)

    let region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 300, 300)
    
    mapView.setRegion(region, animated: true)
  }
}

//: [Next](@next)
