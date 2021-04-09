//
//  AROCKCAnvas.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 4/10/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import UIKit

public class AROCKCanvas: UIView {
    public var selectedType: AROCKMarkupType?
    public var selectedColor: UIColor?
    public var markups: [AROCKMarkup]!
    public var markup: AROCKMarkup!
    public var selectedMarkup: AROCKMarkup?
    
    public var skipDrawing = false

    public init(frame:CGRect, markups: [AROCKMarkup]?) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        if markups != nil {
            self.markups = markups
        } else {
            self.markups = [AROCKMarkup]()
        }
        
        markup = AROCKMarkup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//  Handle Touches for Drawing
public extension AROCKCanvas {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)

            if markup.markupType != .eraser {
                markup.drawPoints = [CGPoint]()
                markup.startPoint = location
                markup.drawPoints.append(location)
            } else {
                for dMarkup in markups {
                    if dMarkup.pointContainInDrawing(location) {
                        self.selectedMarkup = dMarkup
                    }
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)

            if markup.markupType != .eraser {
                markup.endPoint = CGPoint(x: location.x, y: location.y)
                markup.drawPoints.append(location)
            } else {
                skipDrawing = true
            }
        }
        
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if markup.markupType != .eraser {
                markup.endPoint = CGPoint(x: location.x, y: location.y)
                let newMarkup = AROCKMarkup(markup: markup)
                markups.append(newMarkup)
            } else {
                if selectedMarkup != nil {
                    if let markupIndex = markups.firstIndex(where: {$0 === selectedMarkup}) {
                        markups.remove(at: markupIndex)
                    }
                }
            }
            
            skipDrawing = true
        }
        
        self.setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !self.isUserInteractionEnabled {
            super.touchesCancelled(touches, with: event)
            return
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        for newMarkup in markups {
            self.drawShapeRoutine(newMarkup, context: context!)
        }
        
        if !skipDrawing {
            self.drawShapeRoutine(self.markup, context: context!)
        }
        
        self.skipDrawing = false
    }
    
    func drawShapeRoutine(_ markup:AROCKMarkup, context:CGContext) {

        switch markup.markupType {
        case .pen:
            context.setLineWidth(4)
        case .pencil:
            context.setLineWidth(2)
        case .marker:
            context.setLineWidth(15)
        default:
            break
        }
        
        if markup.markupType == .marker {
            context.setStrokeColor(markup.strokeColor.withAlphaComponent(0.5).cgColor)
        } else {
            context.setStrokeColor(markup.strokeColor.cgColor)
        }

        context.setLineDash(phase: 0, lengths: [])
        
        if markup.drawPoints != nil {
            self.drawFreehandPath(context, points: markup.drawPoints)
        }
    }
    
    func drawFreehandPath(_ context: CGContext, points: [CGPoint]) {
        context.beginPath()
        
        for i in 0 ..< points.count {
            let point = points[i]
            if i == 0 {
                context.move(to: CGPoint(x: point.x, y: point.y));
            } else {
                context.addLine(to: CGPoint(x: point.x, y: point.y));
            }
        }
        
        context.strokePath()
    }
}
