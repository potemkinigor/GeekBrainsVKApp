//
//  TestViewController.swift
//  VKApp
//
//  Created by User on 13.02.2021.
//

import UIKit

class LoadingViewController: UIViewController {
    
    var animationView = UIView()
    let maskLayer = CAShapeLayer()
    let cloudIndicator = UIBezierPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        animationView.frame = CGRect(x: self.view.center.x - 200, y: self.view.center.y - 100, width: 400, height: 200)
        animationView.backgroundColor = .white
        self.view.addSubview(animationView)
        
        maskLayer.fillColor = UIColor.clear.cgColor
        maskLayer.strokeColor = UIColor.blue.cgColor
        maskLayer.lineWidth = 2
        
        let rect = self.animationView.frame
        let sideOne = rect.width * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/3
        
//        guard let drawContext = UIGraphicsGetCurrentContext() else { return }
//        drawContext.setStrokeColor(UIColor.blue.cgColor)
        
        cloudIndicator.addArc(withCenter: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 320.degreesToRadians, clockwise: true)
        cloudIndicator.addArc(withCenter: CGPoint(x: rect.width * 0.5, y: rect.height * 0.35), radius: arcRadius, startAngle: 227.degreesToRadians, endAngle: 320.degreesToRadians, clockwise: true)
        cloudIndicator.addArc(withCenter: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: 227.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
        
        cloudIndicator.close()
        cloudIndicator.stroke()
        
        maskLayer.path = cloudIndicator.cgPath
        self.animationView.layer.mask = maskLayer
        self.animationView.layer.addSublayer(maskLayer)
        
//        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        strokeAnimation.fromValue = 0
//        strokeAnimation.toValue = 1
//        strokeAnimation.duration = 10
//        maskLayer.add(strokeAnimation, forKey: nil)
        
        animateLoading()
        
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let targetTabBarController = storyBoard.instantiateViewController(identifier: "TabBarController")
        self.present(targetTabBarController, animated: true, completion: nil)
        
    }
    
    func animateLoading () {
        let circleLayer = CAShapeLayer()
        circleLayer.backgroundColor = UIColor.red.cgColor
        circleLayer.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        circleLayer.position = CGPoint(x: 40, y: 20)
        circleLayer.cornerRadius = 10
        
        let followPathAnimation = CAKeyframeAnimation(keyPath: "position")
        followPathAnimation.path = self.cloudIndicator.cgPath
        followPathAnimation.calculationMode = CAAnimationCalculationMode.paced
        followPathAnimation.speed = 0.05
        followPathAnimation.repeatCount = Float.infinity

        circleLayer.add(followPathAnimation, forKey: nil)
        
        maskLayer.addSublayer(circleLayer)
    }

}
