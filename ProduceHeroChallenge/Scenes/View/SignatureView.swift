//
//  SignatureView.swift
//  ProduceHeroChallenge
//
//  Created by Li Pan on 2020-02-23.
//  Copyright © 2020 Li Pan. All rights reserved.
//

import UIKit

class SignatureView: UIView {
    
    private lazy var path = UIBezierPath()
    private lazy var previousTouchPoint = CGPoint.zero
    private lazy var shapeLayer = CAShapeLayer()
    
    var paths: [UIBezierPath] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupView(){
        layer.addSublayer(shapeLayer)
        shapeLayer.lineWidth = 7
        shapeLayer.strokeColor = UIColor.black.cgColor
    }
    
    func clear() {
        paths.removeAll()
        shapeLayer.path = nil
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let location = touches.first?.location(in: self) {
            previousTouchPoint = location
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let location = touches.first?.location(in: self) {
            path.move(to: location)
            path.addLine(to: previousTouchPoint)
            previousTouchPoint = location
            shapeLayer.path = path.cgPath
            paths.append(path)
        }
    }
}
