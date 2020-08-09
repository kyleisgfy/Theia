//
//  LevelView.swift
//  Theia
//
//  Created by Kyle Schneider on 8/8/20.
//  Copyright © 2020 Kyle Schneider. All rights reserved.
//

import UIKit

class LevelView: UIView {
    
    var levelDotX: CGFloat = 0.0
    var levelDotY: CGFloat = 0.0
    var centerPoint = CGPoint(x: 0, y: 0)
    var levelBool = true
    
    override func draw(_ rect: CGRect) {
        
        guard let currentContext = UIGraphicsGetCurrentContext() else {
        print("Cound not get context.")
        return }
        
        draw_level_outline(user: currentContext, isFilled: levelBool)
        draw_level_dot(user: currentContext, isFilled: true)
        print("Level view updated.")
        
        
    }
    
    func updateView() {
        print("Update level view has been called.")
        setNeedsDisplay()
    }
    
    private func draw_level_outline(user context: CGContext, isFilled: Bool) {
        let centerPoint = CGPoint(x: bounds.size.width/2 , y: bounds.size.height/2)
        let colorRadius = sqrt(levelDotX*levelDotX + levelDotY*levelDotY)*324.6753246753
        var color = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        print("radius: \(colorRadius)")
        if abs(colorRadius) < 10 {
            self.levelBool = true
        } else {
            self.levelBool = false
        }
        if abs(colorRadius) < 10 {
            color = UIColor.white
        } else if abs(colorRadius) < 127.5 {
            color = UIColor(red: colorRadius*2/255.0, green: 255/255.0, blue: 0/255.0, alpha: 1.0)
        } else if abs(colorRadius) >= 127.5 {
            color = UIColor(red: 255.0/255.0, green: (255-colorRadius)*2/255.0, blue: 0/255.0, alpha: 1.0)
        } else {
            color = UIColor.black
        }
        print("x rotation: \(levelDotX)")
        print("y rotation: \(levelDotY)")
        context.addArc(center: centerPoint, radius: 50, startAngle: 0, endAngle: 6.28319, clockwise: false)
        context.setLineWidth(3)
        context.setFillColor(UIColor.green.cgColor)
        context.setStrokeColor(color.cgColor)
        if levelBool == true {
            context.fillPath()
        } else {
            context.strokePath()
        }
    }
    
    private func draw_level_dot(user context: CGContext, isFilled: Bool) {
        let radius = CGFloat(42.5)
        if sqrt((levelDotX * levelDotX * 3600) + (levelDotY * levelDotY * 3600)) < radius {
            centerPoint.x = bounds.size.width/2 + (levelDotX * 60)
            centerPoint.y = bounds.size.height/2 + (levelDotY * 60)
        } else {
            let angle = atan((levelDotY)/(levelDotX))
            if levelDotX < 0 {
                centerPoint.x = cos(angle-3.14159) * radius + bounds.size.width/2
                centerPoint.y = sin(angle-3.14159) * radius + bounds.size.height/2
            } else {
                print("angle: \(angle * 180 / .pi)")
                centerPoint.x = cos(angle) * radius + bounds.size.width/2
                centerPoint.y = sin(angle) * radius + bounds.size.height/2
            }
        }
        context.addArc(center: centerPoint, radius: 5, startAngle: 0, endAngle: 6.28319, clockwise: true)
        if levelBool == true {
            context.setFillColor(UIColor.white.cgColor)
        } else {
            context.setFillColor(UIColor.green.cgColor)
        }
        context.fillPath()
    }
    
    
    


}
