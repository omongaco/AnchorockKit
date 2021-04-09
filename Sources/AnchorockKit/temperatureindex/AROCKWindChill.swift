//
//  AROCKWindChill.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 4/1/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import Foundation
import UIKit

public class AROCKWindChill: UIView {
    
    public enum ChillIndex {
        case minimal
        case low
        case medium
        case high
        case extreme
    }
    
    public var x: CGFloat = 0
    public var y: CGFloat = 0
    public var viewCenter: CGPoint = CGPoint()
    public var increase : CGFloat = 0
    public var index: ChillIndex = .minimal
    
    public init(frame: CGRect, index: ChillIndex) {
        super.init(frame: frame)
        self.x = frame.width / 2
        self.y = frame.height / 2
        self.index = index
        self.viewCenter = CGPoint(x: x, y: y)
        self.increase = 180/5
        
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func degreesToRadians(_ degree: CGFloat) -> CGFloat {
        return degree * .pi / 180
    }
    
    private func configureView() {

        let bgPath = UIBezierPath()
        bgPath.addArc(withCenter: center, radius: x, startAngle: degreesToRadians(CGFloat(180)), endAngle: degreesToRadians(CGFloat(0)), clockwise: true)
        bgPath.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = bgPath.cgPath
        shapeLayer.fillColor = UIColor.darkGray.cgColor
        
        let minimumPath = UIBezierPath()
        minimumPath.addArc(withCenter: center, radius: x - 2, startAngle: degreesToRadians(CGFloat(180)), endAngle: degreesToRadians(CGFloat(180 + (increase))), clockwise: true)
        minimumPath.addLine(to: center)
        minimumPath.close()
        
        let minimumLayer = CAShapeLayer()
        minimumLayer.path = minimumPath.cgPath
        minimumLayer.fillColor = UIColor(red: 156/255.0, green: 234/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        
        let lowPath = UIBezierPath()
        lowPath.addArc(withCenter: center, radius: x - 2, startAngle: degreesToRadians(CGFloat(180 + (increase))), endAngle: degreesToRadians(CGFloat(180 + (increase * 2))), clockwise: true)
        lowPath.addLine(to: center)
        lowPath.close()
        
        let lowLayer = CAShapeLayer()
        lowLayer.path = lowPath.cgPath
        lowLayer.fillColor = UIColor(red: 152/255.0, green: 184/255.0, blue: 254/255.0, alpha: 1.0).cgColor
        
        let moderatePath = UIBezierPath()
        moderatePath.addArc(withCenter: center, radius: x - 2, startAngle: degreesToRadians(CGFloat(180 + (increase * 2))), endAngle: degreesToRadians(CGFloat(180 + (increase * 3))), clockwise: true)
        moderatePath.addLine(to: center)
        moderatePath.close()
        
        let moderateLayer = CAShapeLayer()
        moderateLayer.path = moderatePath.cgPath
        moderateLayer.fillColor = UIColor(red: 128/255.0, green: 159/255.0, blue: 231/255.0, alpha: 1.0).cgColor
        
        let highPath = UIBezierPath()
        highPath.addArc(withCenter: center, radius: x - 2, startAngle: degreesToRadians(CGFloat(180 + (increase * 3))), endAngle: degreesToRadians(CGFloat(0)), clockwise: true)
        highPath.addLine(to: center)
        highPath.close()
        
        let highLayer = CAShapeLayer()
        highLayer.path = highPath.cgPath
        highLayer.fillColor = UIColor(red: 87/255.0, green: 109/255.0, blue: 247/255.0, alpha: 1.0).cgColor
        
        let extremePath = UIBezierPath()
        extremePath.addArc(withCenter: center, radius: x - 2, startAngle: degreesToRadians(CGFloat(180 + (increase * 4))), endAngle: degreesToRadians(CGFloat(0)), clockwise: true)
        extremePath.addLine(to: center)
        extremePath.close()
        
        let extremeLayer = CAShapeLayer()
        extremeLayer.path = extremePath.cgPath
        extremeLayer.fillColor = UIColor(red: 65/255.0, green: 37/255.0, blue: 104/255.0, alpha: 1.0).cgColor
        
        let labelPath = UIBezierPath()
        labelPath.addArc(withCenter: center, radius: x - 4, startAngle: degreesToRadians(CGFloat(180)), endAngle: degreesToRadians(CGFloat(0)), clockwise: true)
        labelPath.addLine(to: CGPoint(x: self.frame.size.width - 50, y: center.y))
        labelPath.addArc(withCenter: center, radius: x - 22, startAngle: degreesToRadians(CGFloat(0)), endAngle: degreesToRadians(CGFloat(180)), clockwise: false)
        labelPath.close()

        let labelLayer = CAShapeLayer()
        labelLayer.path = labelPath.cgPath
        labelLayer.fillColor = UIColor.black.withAlphaComponent(0.6).cgColor
        
        self.layer.addSublayer(shapeLayer)
        self.layer.addSublayer(minimumLayer)
        self.layer.addSublayer(lowLayer)
        self.layer.addSublayer(moderateLayer)
        self.layer.addSublayer(highLayer)
        self.layer.addSublayer(extremeLayer)
        self.layer.addSublayer(labelLayer)
        
        let roundKnob = UIView()
        roundKnob.center = CGPoint(x:center.x - 40, y: center.y - 40)
        roundKnob.frame.size = CGSize(width: 80, height: 80)
        roundKnob.backgroundColor = .groupTableViewBackground
        roundKnob.layer.cornerRadius = 40
        self.addSubview(roundKnob)
        
        let needleView = UIImageView(frame: CGRect(x: x - 10, y: y - 50, width: 20, height: 100))
        needleView.image = UIImage(named: "gauge_needle")
        self.addSubview(needleView)

        let angleRadian = getChillIndexFloat(index: index) / 180 * CGFloat.pi
        needleView.transform = needleView.transform.rotated(by: angleRadian)
    }
    
    private func getChillIndexFloat(index: ChillIndex) -> CGFloat {
        switch index {
        case .minimal:
            return CGFloat(270 + (increase/2))
        case .low:
            return CGFloat(270 + (increase + (increase/2)))
        case .medium:
            return CGFloat(270 + ((increase * 2) + (increase/2)))
        case .high:
            return CGFloat(270 + ((increase * 3) + (increase/2)))
        case .extreme:
            return CGFloat(270 + ((increase * 4) + (increase/2)))
        }
    }
}
