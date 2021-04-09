//
//  AROCKMarkup.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 4/10/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import UIKit

public class AROCKMarkup {
    public var markupType:AROCKMarkupType = .pencil
    public var strokeWidth:CGFloat!
    public var strokeColor = UIColor.white
    public var startPoint:CGPoint!
    public var endPoint:CGPoint!
    public var drawPoints:[CGPoint]!
    public var color = UIColor.white
    public var selected = false
    
    public init() {
    }
    
    public init(markup: AROCKMarkup) {
        self.markupType = markup.markupType
        self.strokeWidth = markup.strokeWidth
        self.strokeColor = markup.strokeColor
        self.startPoint = markup.startPoint
        self.endPoint = markup.endPoint
        self.drawPoints = markup.drawPoints
        self.color = markup.color
    }
    
    public func pointContainInDrawing(_ point:CGPoint) -> Bool {
        if drawPoints != nil {
            let drawBerzier = UIBezierPath()
            for i in 0 ..< drawPoints!.count {
                let point = drawPoints![i]
                if i == 0 {
                    drawBerzier.move(to: point)
                } else {
                    drawBerzier.addLine(to: point)
                }
            }
            let pathRect = drawBerzier.cgPath.boundingBoxOfPath
            drawBerzier.removeAllPoints()
            
            return pathRect.contains(point)
        }
        
        return false
    }
}

