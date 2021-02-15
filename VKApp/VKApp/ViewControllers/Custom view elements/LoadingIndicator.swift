//
//  LoadingIndicator.swift
//  VKApp
//
//  Created by User on 13.02.2021.
//

import Foundation
import UIKit

@IBDesignable class LoadingIndicator: UIView {
    var stackView = UIStackView()
    var pointsArray: [UIView] = []
    var timer = Timer()
    
    var isLoading = true {
        didSet {
            loadingTimer ()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareIndicators ()
        loadingTimer()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareIndicators ()
        loadingTimer()
    }
    
    
    func prepareIndicators () {
        pointsArray.removeAll()
        pointsArray.append(UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20)))
        pointsArray.append(UIView(frame: CGRect(x: 25, y: 0, width: 20, height: 20)))
        pointsArray.append(UIView(frame: CGRect(x: 50, y: 0, width: 20, height: 20)))
        
        
        for point in pointsArray {
            point.backgroundColor = .gray
            point.layer.cornerRadius = 20
            self.addSubview(point)
        }
    }
    
    func loadingEffect () {
        
        let firstPointAnimation = CABasicAnimation(keyPath: "opacity")
        firstPointAnimation.fromValue = 0
        firstPointAnimation.toValue = 1
        firstPointAnimation.duration = 0.25
        firstPointAnimation.beginTime = CACurrentMediaTime()

        firstPointAnimation.fillMode = .forwards
        firstPointAnimation.isRemovedOnCompletion = false
        self.pointsArray[0].layer.add(firstPointAnimation, forKey: "opacityAnimation")
        firstPointAnimation.isRemovedOnCompletion = true

        let secondPointAnimation = firstPointAnimation
        secondPointAnimation.beginTime = CACurrentMediaTime() + firstPointAnimation.duration

        secondPointAnimation.fillMode = .forwards
        secondPointAnimation.isRemovedOnCompletion = false
        self.pointsArray[1].layer.add(secondPointAnimation, forKey: "opacityAnimation")
        secondPointAnimation.isRemovedOnCompletion = true

        let thirdPointAnimation = secondPointAnimation
        thirdPointAnimation.beginTime = CACurrentMediaTime() + firstPointAnimation.duration + secondPointAnimation.duration

        thirdPointAnimation.fillMode = .forwards
        thirdPointAnimation.isRemovedOnCompletion = false
        self.pointsArray[2].layer.add(thirdPointAnimation, forKey: "opacityAnimation")
        thirdPointAnimation.isRemovedOnCompletion = true

    }
    
    func loadingTimer () {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [self]timer in
            if self.isLoading {
                self.loadingEffect ()
            }
        })
    }
    
    
    
}
