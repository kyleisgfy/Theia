//
//  FirstViewController.swift
//  Theia
//
//  Created by Kyle Schneider on 8/8/20.
//  Copyright © 2020 Kyle Schneider. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var objectSelector: UIPickerView!
    
    @IBOutlet weak var rightAscensionLabel: UILabel!
    @IBOutlet weak var declinationLabel: UILabel!
    @IBOutlet weak var azimuthLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    
    var content = ""
    var catalogue:[[CustomStringConvertible]] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCatalgue(file: "Catalogue")
        objectSelector.dataSource = self
        objectSelector.delegate = self
        
        
        
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
        self.rightAscensionLabel.text = (catalogue[row][3] as!String)
        self.declinationLabel.text = (catalogue[row][4] as!String)
        
        return (catalogue [row][0] as! String)
    }
    
    


}



