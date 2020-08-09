//
//  Formulas.swift
//  Theia
//
//  Created by Kyle Schneider on 8/9/20.
//  Copyright © 2020 Kyle Schneider. All rights reserved.
//

import Foundation

class Formulas: NSObject {
    
    let siderealDay = 86164.0905


    func toDegrees(radians : Double) -> Double {
        return (radians / 180 * .pi)
    }
    func toRadians(degrees : Double) -> (Double) {
        return (degrees * .pi / 180)
    }
    
//    parce and convert string to Double
    
    
    func timeSinceVernalEquinox(now: Double) -> Double {
//        Needs completion (find seconds since now from vernal equinox)
        let origin:Double = 0
        let timeSince = now - origin
        return timeSince
    }
    
    func rightAscensionToAngleOfAscension(rightAscension : Double, timeSince: Double) -> Double {
//        Needs completion (should rotate with time and based on prime meridian)
        let angleOfAscension = rightAscension + timeSince - 90
        return angleOfAscension
    }
    
    func angleOfAscensionAndDeclinationToXYZ(angleOfAscension : Double, Declination : Double) -> (Double, Double, Double) {
        let x = sin(toRadians(degrees: angleOfAscension)) * cos(toRadians(degrees: Declination))
        let y = sin(toRadians(degrees: Declination))
        let z = sin(toRadians(degrees: Double(90) - angleOfAscension)) * sin(toRadians(degrees: Double(90) - Declination))
        return (x, y, z)
    }
    
    func xyzToAzimuthAndAltitude(x: Double, y: Double, z: Double) -> (Double, Double) {
        let azimuth = toDegrees(radians: asin(x + sqrt((x*x)+(y+y))))
        let altitude = toDegrees(radians: atan(z + sqrt((x*x)+(y*y))))
        return (azimuth, altitude)
    }
    
    func rightAscensionAndDeclinationToAzimuthAndAltitude(rightAscension : Double, declination : Double, longitude: Double, latitude: Double, now: Double) -> (Double, Double) {
//        Needs Competion
        let timeSince = timeSinceVernalEquinox(now: now)
        let angleOfAscension = rightAscensionToAngleOfAscension(rightAscension: rightAscension, timeSince: timeSince)
        let (x, y, z) = angleOfAscensionAndDeclinationToXYZ(angleOfAscension: angleOfAscension, Declination: declination)
        let (azimuth, altitude) = xyzToAzimuthAndAltitude(x: x, y: y, z: z)
        return (azimuth, altitude)
    }
    


    func translateXYZWithLocation(longitude : Double, Latitude : Double, timeSince: Double) -> (Double, Double, Double) {
//        Needs Completion
        let x:Double = 0
        let y:Double = 0
        let z:Double = 0
        return (x, y, z)
    }
}
