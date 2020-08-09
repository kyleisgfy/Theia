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
    
    var northHeading:Double = 0

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
        motion.startDeviceMotionUpdates(using: CMAttitudeReferenceFrame.xTrueNorthZVertical, to: OperationQueue.current!) {
             (data, error) in
            self.compassView.trueNorth = CGFloat(data?.heading ?? 0)
            self.levelView.levelDotX = CGFloat(data?.attitude.roll ?? 0)
            self.levelView.levelDotY = CGFloat(data?.attitude.pitch ?? 0)
            self.compassView.updateView()
            self.levelView.updateView()
        }
    }
    
    

}
