//
//  MapViewController.swift
//  HikingAI
//
//  Created by Yaroslav Spirin on 16/11/2019.
//  Copyright © 2019 Yaroslav Spirin. All rights reserved.
//

import UIKit
import MapKit
import FittedSheets

class MapViewController: UIViewController, MKMapViewDelegate {
    
    enum State {
        case drawing
        case showing
    }
    
    public var state: State = .showing

    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var drawButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var overlayImageView: UIImageView!
    
    
    
    @IBAction func drawButtonTapped(_ sender: Any) {
        switch state {
        case .drawing:
            mapView.isUserInteractionEnabled = true
            state = .showing
            drawButton.setImage(UIImage(named: "edit"), for: .normal)
            renderPointsToMap()
            overlayImageView.image = nil
            
            
        case .showing:
            mapView.isUserInteractionEnabled = false
            state = .drawing
            drawButton.setImage(UIImage(named: "map"), for: .normal)
            
        }
    }
    
    private func renderPointsToMap() {
        let locations = points.map { (point) in
            return self.mapView.convert(point, toCoordinateFrom: self.mapView)
        }
        
        let polyline = MKPolyline(coordinates: locations, count: locations.count)
        mapView.addOverlay(polyline)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        var pr = MKPolylineRenderer(overlay: overlay)
        pr.strokeColor = UIColor.random()
        pr.lineWidth = 5
        return pr
    }
    
    @objc private func backItemTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        self.bottomImageView.alpha = 0.0
        
        configureDrawButton()
        calibrateRegion()
        configureMapView()
        configureNavigationBar()
        configureJSON()
        showRoutes()
    }
    
    func configureDrawButton() {
        drawButton.layer.cornerRadius = drawButton.bounds.height / 2.0
    }
    
    func showRoutes() {
        let introLocations = Routes.lowerIntroTravel.map {
            return CLLocationCoordinate2D(latitude: $0[0], longitude: $0[1])
        }
        
        let hypeLocations = Routes.lowerHypeTravel.map {
            return CLLocationCoordinate2D(latitude: $0[0], longitude: $0[1])
        }
        
        let peacefulLocations = Routes.lowerPeacefulTravel.map {
            return CLLocationCoordinate2D(latitude: $0[0], longitude: $0[1])
        }
        
        let polyline1 = MKPolyline(coordinates: introLocations, count: introLocations.count)
        mapView.addOverlay(polyline1)
        
        let polyline2 = MKPolyline(coordinates: hypeLocations, count: hypeLocations.count)
        mapView.addOverlay(polyline2)
        
        let polyline3 = MKPolyline(coordinates: peacefulLocations, count: peacefulLocations.count)
        mapView.addOverlay(polyline3)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        let customPointAnnotation = annotation as! CustomPointAnnotation
        annotationView?.image = UIImage(named: customPointAnnotation.imagePath!)

        return annotationView
    }
    
    private func calibrateRegion() {
        guard let park = UserDefaults.standard.object(forKey: "park") as? String else {
            return
        }
        
        var location = CLLocationCoordinate2D(latitude: 60.3128, longitude: 24.4809)
        
        if park == "pallas_huy" {
            location = CLLocationCoordinate2D(latitude: 67.9667, longitude: 24.1333)
        }
        
        let region = MKCoordinateRegion(center: location,
                                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(region, animated: true)
    }
    
    private func showViewPoints(json: [Any]?) {
        guard let json = json else {
            return
        }
        
        var coords: [(Double, Double, String, String)] = []
        for view in json {
            if let view = view as? [String : Any],
                let location = view["location"] as? [Any],
                let title = view["name"] as? String,
                let subtitle = view["description"] as? String,
                let lat = location[0] as? Double,
                let lon = location[1] as? Double {
                coords.append((lat, lon, title, subtitle))
            }
        }
        
        coords.forEach { (x, y, title, subtitle) in
            let annotation = CustomPointAnnotation()
            annotation.imagePath = "eye"
            annotation.coordinate = CLLocationCoordinate2D(latitude: x, longitude: y)
            annotation.title = title
            annotation.subtitle = subtitle
            mapView.addAnnotation(annotation)
        }
    }
    
    private func showToilets(json: [Any]?) {
        guard let json = json else {
            return
        }
        
        var coords: [(Double, Double)] = []
        for toilet in json {
            if let toilet = toilet as? [String : Any],
                let location = toilet["location"] as? [Any],
                let lat = location[0] as? Double,
                let lon = location[1] as? Double {
                coords.append((lat, lon))
            }
        }
        
        coords.forEach { (x, y) in
            let annotation = CustomPointAnnotation()
            annotation.imagePath = "wc"
            annotation.coordinate = CLLocationCoordinate2D(latitude: x, longitude: y)
            annotation.title = "WC"
            mapView.addAnnotation(annotation)
        }
    }
    
    private func showCamps(json: [Any]?) {
        guard let json = json else {
            return
        }
        
        var coords: [(Double, Double, String, String)] = []
        for camp in json {
            if let camp = camp as? [String : Any],
                let location = camp["location"] as? [Any],
                let title = camp["name"] as? String,
                let subtitle = camp["description"] as? String,
                let lat = location[0] as? Double,
                let lon = location[1] as? Double {
                coords.append((lat, lon, title, subtitle))
            }
        }
        
        coords.forEach { (x, y, title, subtitle) in
            let annotation = CustomPointAnnotation()
            annotation.imagePath = "camp"
            annotation.coordinate = CLLocationCoordinate2D(latitude: x, longitude: y)
            annotation.title = title
            annotation.subtitle = subtitle
            mapView.addAnnotation(annotation)
        }
    }
    
    private func showFireplace(json: [Any]?) {
        guard let json = json else {
            return
        }
        
        var coords: [(Double, Double, String, String)] = []
        for fireplace in json {
            if let fireplace = fireplace as? [String : Any],
                let location = fireplace["location"] as? [Any],
                let title = fireplace["name"] as? String,
                let subtitle = fireplace["description"] as? String,
                let lat = location[0] as? Double,
                let lon = location[1] as? Double {
                coords.append((lat, lon, title, subtitle))
            }
        }
        
        coords.forEach { (x, y, title, subtitle) in
            let annotation = CustomPointAnnotation()
            annotation.imagePath = "fire"
            annotation.coordinate = CLLocationCoordinate2D(latitude: x, longitude: y)
            annotation.title = title
            annotation.subtitle = subtitle
            mapView.addAnnotation(annotation)
        }
    }
    
    private func showInfoPoints(json: [Any]?) {
        guard let json = json else {
            return
        }
        
        var coords: [(Double, Double, String, String)] = []
        for infoplace in json {
            if let infoplace = infoplace as? [String : Any],
                let location = infoplace["location"] as? [Any],
                let title = infoplace["name"] as? String,
                let subtitle = infoplace["description"] as? String,
                let lat = location[0] as? Double,
                let lon = location[1] as? Double {
                coords.append((lat, lon, title, subtitle))
            }
        }
        
        coords.forEach { (x, y, title, subtitle) in
            let annotation = CustomPointAnnotation()
            annotation.imagePath = "info"
            annotation.coordinate = CLLocationCoordinate2D(latitude: x, longitude: y)
            annotation.title = title
            annotation.subtitle = subtitle
            mapView.addAnnotation(annotation)
        }
    }
    
    private func showParkings(json: [Any]?) {
        guard let json = json else {
            return
        }
        
        var coords: [(Double, Double, String, String)] = []
        for parking in json {
            if let parking = parking as? [String : Any],
                let location = parking["location"] as? [Any],
                let title = parking["name"] as? String,
                let subtitle = parking["description"] as? String,
                let lat = location[0] as? Double,
                let lon = location[1] as? Double {
                coords.append((lat, lon, title, subtitle))
            }
        }
        
        coords.forEach { (x, y, title, subtitle) in
            let annotation = CustomPointAnnotation()
            annotation.imagePath = "parking"
            annotation.coordinate = CLLocationCoordinate2D(latitude: x, longitude: y)
            annotation.title = title
            annotation.subtitle = subtitle
            mapView.addAnnotation(annotation)
        }
    }
    
    private func configureJSON() {
        var filename = "nuuksio"
        
        guard let park = UserDefaults.standard.object(forKey: "park") as? String else {
            return
        }
        
        if park == "pallas_huy" {
            filename = "pallas"
        }
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return
        }
        
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        guard let dict = json as? [String : Any] else {
            return
        }
        
        showViewPoints(json: dict["view_points"] as? [Any])
        showToilets(json: dict["toilets"] as? [Any])
        showCamps(json: dict["camping"] as? [Any])
        showFireplace(json: dict["fireplaces"] as? [Any])
        showInfoPoints(json: dict["info_points"] as? [Any])
        showParkings(json: dict["parkings"] as? [Any])
    }
    
    private func configureMapView() {
        let mapTap = UITapGestureRecognizer(target: self, action: #selector(mapTapped(_:)))
        mapView.addGestureRecognizer(mapTap)
        
        guard let park = UserDefaults.standard.object(forKey: "park") as? String else {
            return
        }
        
        var filename = "nuuksio"
        
        if park == "pallas_huy" {
            filename = "pallas"
        }
        
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                return
        }
        
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
    }
    
    private func configureNavigationBar() {
        let leftItem = UIBarButtonItem(title: "Back",
                                       style: .plain,
                                       target: self,
                                       action: #selector(backItemTapped))
        
        self.navigationController?.navigationBar.tintColor = .systemIndigo
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.title = "Map"
        self.navigationItem.hidesBackButton = true
    }
    
    @objc func mapTapped(_ tap: UITapGestureRecognizer) {
        if tap.state == .recognized && tap.state == .recognized {
            // Get map coordinate from touch point
            let touchPt: CGPoint = tap.location(in: mapView)
            let coord: CLLocationCoordinate2D = mapView.convert(touchPt, toCoordinateFrom: mapView)
            let maxMeters: Double = meters(fromPixel: 22, at: touchPt)
            var nearestDistance: Float = MAXFLOAT
            var nearestPoly: MKPolyline? = nil
            // for every overlay ...
            for overlay: MKOverlay in mapView.overlays {
                // .. if MKPolyline ...
                if (overlay is MKPolyline) {
                    // ... get the distance ...
                    let distance: Float = Float(distanceOf(pt: MKMapPoint(coord), toPoly: overlay as! MKPolyline))
                    // ... and find the nearest one
                    if distance < nearestDistance {
                        nearestDistance = distance
                        nearestPoly = overlay as! MKPolyline
                    }

                }

            }

            if Double(nearestDistance) <= maxMeters {
                print("Touched poly: \(nearestPoly) distance: \(nearestDistance)")
                UIView.animate(withDuration: 0.3, animations: {
                    self.bottomImageView.image = [UIImage(named: "intro")!, UIImage(named: "hype")!, UIImage(named: "peaceful")!].random()
                    self.bottomImageView.alpha = 1.0
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.bottomImageView.image = [UIImage(named: "intro")!, UIImage(named: "hype")!, UIImage(named: "peaceful")!].random()
                    self.bottomImageView.alpha = 0.0
                })
            }
        }
    }
    
    func distanceOf(pt: MKMapPoint, toPoly poly: MKPolyline) -> Double {
        var distance: Double = Double(MAXFLOAT)
        for n in 0..<poly.pointCount - 1 {
            let ptA = poly.points()[n]
            let ptB = poly.points()[n + 1]
            let xDelta: Double = ptB.x - ptA.x
            let yDelta: Double = ptB.y - ptA.y
            if xDelta == 0.0 && yDelta == 0.0 {
                continue
            }
            let u: Double = ((pt.x - ptA.x) * xDelta + (pt.y - ptA.y) * yDelta) / (xDelta * xDelta + yDelta * yDelta)
            var ptClosest: MKMapPoint
            if u < 0.0 {
                ptClosest = ptA
            }
            else if u > 1.0 {
                ptClosest = ptB
            }
            else {
                ptClosest = MKMapPoint(x: ptA.x + u * xDelta, y: ptA.y + u * yDelta)
            }

            distance = min(distance, ptClosest.distance(to: pt))
        }
        return distance
    }

    func meters(fromPixel px: Int, at pt: CGPoint) -> Double {
        let ptB = CGPoint(x: pt.x + CGFloat(px), y: pt.y)
        let coordA: CLLocationCoordinate2D = mapView.convert(pt, toCoordinateFrom: mapView)
        let coordB: CLLocationCoordinate2D = mapView.convert(ptB, toCoordinateFrom: mapView)
        return MKMapPoint(coordA).distance(to: MKMapPoint(coordB))
    }
    
    var points = [CGPoint]()
    var color = UIColor.black
    var brushWidth: CGFloat = 2.0
    var opacity: CGFloat = 1.0
    var swiped = false
    var lastPoint = CGPoint.zero {
        didSet {
            points.append(lastPoint)
        }
    }
}

extension MapViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, state == .drawing else {
          return
        }
        
        swiped = false
        points = []
        overlayImageView.image = nil
        lastPoint = touch.location(in: mapView)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
          drawLine(from: lastPoint, to: lastPoint)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, state == .drawing else {
          return
        }

        swiped = true
        let currentPoint = touch.location(in: view)
        drawLine(from: lastPoint, to: currentPoint)
        
        lastPoint = currentPoint
    }
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(mapView.frame.size)
          
        guard let context = UIGraphicsGetCurrentContext() else {
          return
        }
        
        overlayImageView.image?.draw(in: mapView.bounds)
          
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(color.cgColor)
        
        context.strokePath()
        
        overlayImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        overlayImageView.alpha = opacity
        
        UIGraphicsEndImageContext()
    }
}
