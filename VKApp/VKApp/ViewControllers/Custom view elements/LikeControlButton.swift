//
//  LikeControlButton.swift
//  VKApp
//
//  Created by User on 08.02.2021.
//

import UIKit

class LikeControlButton: UIControl {

    let heartBezierPath = UIBezierPath()
    let maskLayer = CAShapeLayer()
    var isLiked = false
    var groupNumber = 0

    override func draw(_ rect: CGRect) {
        super.draw(rect)
    
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setStrokeColor(UIColor.blue.cgColor)
        

        let sideOne = rect.width * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2

        heartBezierPath.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        heartBezierPath.addLine(to: CGPoint(x: rect.width/2, y: rect.height * 0.2))
        heartBezierPath.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        heartBezierPath.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95))
        
        heartBezierPath.close()
        heartBezierPath.stroke()
        
        maskLayer.path = heartBezierPath.cgPath
        
        self.layer.mask = maskLayer
        self.layer.masksToBounds = true
        
        if isLiked {
            UIColor.blue.set()
        } else {
            UIColor.white.set()
        }
        
        heartBezierPath.fill()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isLiked {
            UIColor.white.set()
            self.heartBezierPath.fill()
            setNeedsDisplay()
            
            groups[groupNumber].likes -= 1
            groups[groupNumber].liked = false
            
            isLiked = false
            
        } else {
            UIColor.blue.set()
            self.heartBezierPath.fill()
            setNeedsDisplay()
            
            groups[groupNumber].likes += 1
            groups[groupNumber].liked = true
            
            isLiked = true
        }
    }

}
