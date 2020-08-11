//
//  SecondViewController.swift
//  Theia
//
//  Created by Kyle Schneider on 8/8/20.
//  Copyright © 2020 Kyle Schneider. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

class SecondViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var levelView: LevelView!
    @IBOutlet weak var compassView: CompassView!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLable: UILabel!
    
    var northHeading:Double = 0
    
    var longitude:Double = 0.0
    var latitude:Double = 0.0

    var motion = CMMotionManager()
    var location = CLLocationManager()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        location.delegate = self
        self.location.requestWhenInUseAuthorization()
        updateLocation()
    }

    func updateLocation() {
        motion.deviceMotionUpdateInterval = 0.1
        location.startUpdatingLocation()
        motion.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xTrueNorthZVertical, to: OperationQueue.current!) {
             (data, error) in
            self.compassView.trueNorth = CGFloat(data?.heading ?? 0)
            self.levelView.levelDotX = CGFloat(data?.attitude.roll ?? 0)
            self.levelView.levelDotY = CGFloat(data?.attitude.pitch ?? 0)
            self.compassView.updateView()
            self.levelView.updateView()
            guard let locValue: CLLocationCoordinate2D = self.location.location?.coordinate else { return }
//               print("locations = \(locValue.latitude) \(locValue.longitude)")
            self.longitudeLabel.text = String(self.roundTo(number: locValue.longitude, value: 100))
            self.latitudeLable.text = String(self.roundTo(number: locValue.latitude, value: 100))
            
            
        }
    }
    
    func roundTo(number: Double, value: Double) -> Double {
        let x = round(value * number) / value
        return x
    }
    
//    func manager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//    }

}
