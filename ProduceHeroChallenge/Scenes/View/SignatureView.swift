//
//  SignatureView.swift
//  ProduceHeroChallenge
//
//  Created by Li Pan on 2020-02-23.
//  Copyright © 2020 Li Pan. All rights reserved.
//

import UIKit

class SignatureView: UIView {
    
    var paths: [UIBezierPath] = []

    override func draw(_ rect: CGRect) {
        for path in paths {
           path.stroke()
            animatePath(path)
        }
     }
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let cgPoint = touches.first?.location(in: self) {
            
            let path = UIBezierPath()
            path.lineWidth = 4.0
            path.move(to: cgPoint)
            paths.append(path)
            animatePath(path)
        }

     }

     override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let cgPoint = touches.first?.location(in: self), let path = paths.last {
            path.addLine(to: cgPoint)
            animatePath(path)
            setNeedsDisplay()
        }
     }
    
    func animatePath(_ path: UIBezierPath) {
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = path.cgPath
        layer.addSublayer(shapeLayer)

        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.duration = 0.0
        strokeEndAnimation.fromValue = 0.0

        shapeLayer.add(strokeEndAnimation, forKey: "strokeEndAnimation")
    }
}
