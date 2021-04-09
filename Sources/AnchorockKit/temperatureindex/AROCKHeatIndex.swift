//
//  AROCKHeatIndex.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 3/29/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import Foundation
import UIKit

public class AROCKHeatIndex: UIView {
    
    public enum HeatIndex {
        case minimalAngle
        case lowAngle
        case moderateAngle
        case highAngle
        case extremeAngle
    }
    
    public var x: CGFloat = 0
    public var y: CGFloat = 0
    public var viewCenter: CGPoint = CGPoint()
    public var increase : CGFloat = 0
    public var index: HeatIndex = .lowAngle
    
    
    public init(frame: CGRect, index: HeatIndex) {
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

        let minimalPath = UIBezierPath()
        minimalPath.addArc(withCenter: center, radius: x - 2, startAngle: degreesToRadians(CGFloat(180)), endAngle: degreesToRadians(CGFloat(180 + increase)), clockwise: true)
        minimalPath.addLine(to: center)
        minimalPath.close()
        
        let minimalLayer = CAShapeLayer()
        minimalLayer.path = minimalPath.cgPath
        minimalLayer.fillColor = UIColor(red: 129/255.0, green: 187/255.0, blue: 63/255.0, alpha: 1.0).cgColor
        
        let lowPath = UIBezierPath()
        lowPath.addArc(withCenter: center, radius: x - 2, startAngle: degreesToRadians(CGFloat(180 + increase)), endAngle: degreesToRadians(CGFloat(180 + (increase * 2))), clockwise: true)
        lowPath.addLine(to: center)
        lowPath.close()
        
        let lowLayer = CAShapeLayer()
        lowLayer.path = lowPath.cgPath
        lowLayer.fillColor = UIColor(red: 197/255.0, green: 251/255.0, blue: 150/255.0, alpha: 1.0).cgColor
        
        let moderatePath = UIBezierPath()
        moderatePath.addArc(withCenter: center, radius: x - 2, startAngle: degreesToRadians(CGFloat(180 + (increase * 2))), endAngle: degreesToRadians(CGFloat(180 + (increase * 3))), clockwise: true)
        moderatePath.addLine(to: center)
        moderatePath.close()
        
        let moderateLayer = CAShapeLayer()
        moderateLayer.path = moderatePath.cgPath
        moderateLayer.fillColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 130/255.0, alpha: 1.0).cgColor
        
        let highPath = UIBezierPath()
        highPath.addArc(withCenter: center, radius: x - 2, startAngle: degreesToRadians(CGFloat(180 + (increase * 3))), endAngle: degreesToRadians(CGFloat(180 + (increase * 4))), clockwise: true)
        highPath.addLine(to: center)
        highPath.close()
        
        let highLayer = CAShapeLayer()
        highLayer.path = highPath.cgPath
        highLayer.fillColor = UIColor(red: 229/255.0, green: 149/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        
        let extremePath = UIBezierPath()
        extremePath.addArc(withCenter: center, radius: x - 2, startAngle: degreesToRadians(CGFloat(180 + (increase * 4))), endAngle: degreesToRadians(CGFloat(0)), clockwise: true)
        extremePath.addLine(to: center)
        extremePath.close()
        
        let extremeLayer = CAShapeLayer()
        extremeLayer.path = extremePath.cgPath
        extremeLayer.fillColor = UIColor.red.cgColor
        
        let labelPath = UIBezierPath()
        labelPath.addArc(withCenter: center, radius: x - 4, startAngle: degreesToRadians(CGFloat(180)), endAngle: degreesToRadians(CGFloat(0)), clockwise: true)
        labelPath.addLine(to: CGPoint(x: self.frame.size.width - 50, y: center.y))
        labelPath.addArc(withCenter: center, radius: x - 22, startAngle: degreesToRadians(CGFloat(0)), endAngle: degreesToRadians(CGFloat(180)), clockwise: false)
        labelPath.close()

        let labelLayer = CAShapeLayer()
        labelLayer.path = labelPath.cgPath
        labelLayer.fillColor = UIColor.black.withAlphaComponent(0.6).cgColor
        
        self.layer.addSublayer(shapeLayer)
        self.layer.addSublayer(minimalLayer)
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

        let angleRadian = getHeatIndexFloat(index: index) / 180 * CGFloat.pi
        needleView.transform = needleView.transform.rotated(by: angleRadian)
    }
    
    private func getHeatIndexFloat(index: HeatIndex) -> CGFloat {
        switch index {
        case .minimalAngle:
            return CGFloat(270 + (increase/2))
        case .lowAngle:
            return CGFloat(270 + (increase + (increase/2)))
        case .moderateAngle:
            return CGFloat(270 + ((increase * 2) + (increase/2)))
        case .highAngle:
            return CGFloat(270 + ((increase * 3) + (increase/2)))
        case .extremeAngle:
            return CGFloat(270 + ((increase * 4) + (increase/2)))
        }
    }
}
