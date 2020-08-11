//
//  FirstViewController.swift
//  Theia
//
//  Created by Kyle Schneider on 8/8/20.
//  Copyright © 2020 Kyle Schneider. All rights reserved.
//

import UIKit
import Foundation

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var objectSelector: UIPickerView!
    
    @IBOutlet weak var rightAscensionLabel: UILabel!
    @IBOutlet weak var declinationLabel: UILabel!
    @IBOutlet weak var azimuthLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    
    
    var content = ""
    var catalogue:[[CustomStringConvertible]] = []
    var selection = 0
    var rightAscension:Double = 0.0
    var declination:Double = 0.0
    var azimuth:Double = 0.0
    var altitude:Double = 0.0
    var longitude:Double = 0.0
    var latitude:Double = 0.0
    var timeSince:Double = 0.0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        (azimuth, altitude) = Formulas().rightAscensionAndDeclinationToAzimuthAndAltitude(rightAscension: rightAscension, declination: declination, longitude: longitude, latitude: latitude, now: timeSince)

        
        updateCatalgue(file: "Catalogue")
        objectSelector.dataSource = self
        objectSelector.delegate = self
        
        
        
        
    }
    
//    func convertToDegrees() {
////        let formulas = Formulas()
//
//        rightAscension = Double(parseRightAscension(selection: selection)) as Double
//        declination = Double(parseDeclination(selection: selection)) as Double
//        (azimuth, altitude) = Formulas.rightAscensionAndDeclinationToAzimuthAndAltitude(rightAscension: rightAscension, declination: declination, longitude: longitude, latitude: latitude, now: timeSince)
//    }
//
    func parseRightAscension(selection: Int) -> Float {
        var string = (catalogue[selection][3] as! String)
        
        string = string.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil)
        string = string.replacingOccurrences(of: "h", with: "", options: NSString.CompareOptions.literal, range:nil)
        string = string.replacingOccurrences(of: "'", with: "", options: NSString.CompareOptions.literal, range:nil)
        
        print(catalogue[selection][3])
        print("Right Ascension: \(string)")
        
        let parts = string.components(separatedBy: " ")
        let hours = Float(parts[0]) ?? 0.0
        let minutes = (Float(parts[1]) ?? 0.0) / 60
        let seconds = (Float(parts[1]) ?? 0.0)/3600
        let degrees = (hours + minutes + seconds) * 15
        
        print("Degrees: \(degrees)")
        print("")
        return degrees
        
    }
    
    func parseDeclination(selection: Int) -> Float {
        var string = (catalogue[selection][4] as! String)
                            
                            
        string = string.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range:nil)
        string = string.replacingOccurrences(of: "º", with: "", options: NSString.CompareOptions.literal, range:nil)
        string = string.replacingOccurrences(of: "'", with: "", options: NSString.CompareOptions.literal, range:nil)
        
        print(catalogue[selection][4])
        print("Declination: \(string)")
        
        let parts = string.components(separatedBy: " ")
        let hours = Float(parts[0]) ?? 0.0
        let minutes = (Float(parts[0]) ?? 0.0) / 60
        let seconds = (Float(parts[0]) ?? 0.0)/3600
        var degrees:Float = 0.0
        if hours < 0 {
            degrees = (hours - minutes - seconds)
        } else {
            degrees = (hours + minutes + seconds)
        }
                            
        print("Degrees: \(degrees)")
        print("")
        return degrees
    }
    
    func updateCatalgue(file: String) {
        
        let filepath:String = Bundle.main.path(forResource: file, ofType: "csv") ?? ""
                
                content = try! String(contentsOfFile: filepath )
                

                catalogue = content
                  .components(separatedBy: "\n")
                  .map({ // Step 1
                    $0.components(separatedBy: ",")
                      .map({ // Step 2
                        if let int = Int($0) {
                          return int
                        } else if let double = Double($0) {
                          return double
                        }
                        return $0
                      })
                  })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return catalogue.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.rightAscensionLabel.text = (catalogue[row][3] as! String)
        self.declinationLabel.text = (catalogue[row][4] as! String)
        
//        self.longitudeLabel.text = String(secondViewController.longitude)
//        self.latitudeLabel.text = String(compassView.latitude)
        
        selection = row
        
        rightAscension = Double(parseRightAscension(selection: selection)) as Double
        declination = Double(parseDeclination(selection: selection)) as Double
        
        
        
        return (catalogue [row][0] as! String)
    }
    
    


}



