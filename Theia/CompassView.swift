//
//  CompassView.swift
//  Theia
//
//  Created by Kyle Schneider on 8/8/20.
//  Copyright © 2020 Kyle Schneider. All rights reserved.
//

import UIKit

class CompassView: UIView {
    
    var trueNorth:CGFloat = 0
    var pointedNorth = false
    
    var longitude:Double = 0.0
    var latitude:Double = 0.0
    
    
    override func draw(_ rect: CGRect) {
    
        guard let currentContext = UIGraphicsGetCurrentContext() else {
           print("Cound not get context.")
           return
        }
        
        updateCompass(user: currentContext, isFilled: pointedNorth)
        compassLines(user: currentContext, isFilled: false)
        
        
        
    }
    
    func updateView() {
        setNeedsDisplay()
        print("needs display was called")
    }
    
    func updateCompass(user context: CGContext, isFilled: Bool) {
        let centerPoint = CGPoint(x: bounds.size.width/2, y: bounds.size.height/2)
        let strokeLevel = ((abs(Int32(trueNorth-180)))/15) + 10
        let radians = trueNorth * .pi / 180
        let degrees = abs(trueNorth - 180)
        let radiusVaried = 60 - strokeLevel
        var direction = false
        var color = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        
        if radians > 3.14159 {
            direction = true
        } else if radians < 3.14159 {
            direction = false
        } else {
            direction = false
        }
        
        context.setLineWidth(CGFloat(strokeLevel))
        context.setStrokeColor(color.cgColor)
        context.setFillColor(UIColor.blue.cgColor)

        if degrees < 90 {
            color = UIColor(red: 1, green: 0, blue: degrees/90.0, alpha: 1.0)
            context.addArc(center: centerPoint, radius: CGFloat(radiusVaried), startAngle: -1.5708, endAngle: CGFloat(radians-1.5708), clockwise: direction)
            self.pointedNorth = false
            context.strokePath()
        } else if degrees >= 90 && degrees < 175 {
            color = UIColor(red: (180-degrees)/90, green: 0, blue: 1, alpha: 1.0)
            context.addArc(center: centerPoint, radius: CGFloat(radiusVaried), startAngle: -1.5708, endAngle: CGFloat(radians-1.5708), clockwise: direction)
            self.pointedNorth = false
            context.strokePath()
        } else if degrees >= 175 {
            color = UIColor(red: 0, green: 0, blue: 1, alpha: 1.0)
            context.addArc(center: centerPoint, radius: CGFloat(50), startAngle: 0, endAngle: 6.28319, clockwise: direction)
            self.pointedNorth = true
            context.fillPath()
        }
    }
    
    func compassLines(user context: CGContext, isFilled: Bool) {
        let lineLength = CGFloat(((abs(Int32((trueNorth-180) / 3)))))
        let degrees = abs(trueNorth - 180)
        var color = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        
        if degrees < 90 {
            color = UIColor(red: 1, green: 0, blue: degrees/90.0, alpha: 1.0)
        } else if degrees >= 90 && degrees < 175 {
            color = UIColor(red: (180-degrees)/90, green: 0, blue: 1, alpha: 1.0)
        } else {
            color = UIColor.white
        }
        
        context.setLineWidth(lineLength/50)
        context.move(to: CGPoint(x: bounds.size.width/2, y: (lineLength / 5) + bounds.size.height/2))
        context.addLine(to: CGPoint(x: bounds.size.width/2, y: (lineLength / -2) + bounds.size.height/2))
        context.move(to: CGPoint(x: (lineLength / -5) + bounds.size.width / 2, y: bounds.size.height/2))
        context.addLine(to: CGPoint(x: (lineLength / 5) + bounds.size.width / 2, y: bounds.size.height/2))
        context.setStrokeColor(color.cgColor)
        context.strokePath()
    }
    
    
}
