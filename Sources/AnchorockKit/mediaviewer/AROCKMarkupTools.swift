//
//  AROCKMarkupTools.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 4/10/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import UIKit

protocol AROCKMarkupToolsDelegate {
    func drawingToolSelected(type: AROCKMarkupType)
    func newColorSelected(color: UIColor)
}

@available(iOS 9.0, *)
public class AROCKMarkupTools: UIView {
    public var view: UIView!
    public var penButton: UIButton!
    public var pencilButton: UIButton!
    public var markerButton: UIButton!
    public var eraserButton: UIButton!
    public var palleteStack: UIStackView!
    public var palleteButton: UIButton!
    public var selectedColor: UIColor = UIColor.white
    public var selectedButton: UIButton!
    
    public var colorPallet: UIView!
    public var colorArray = [UIColor.white, UIColor.black, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.red]
    
    var delegate: AROCKMarkupToolsDelegate?
 
    public override init(frame: CGRect) {
        super.init(frame: frame)
        viewSetup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viewSetup()
    }
    
    private func viewSetup() {
        self.layer.masksToBounds = true
        backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        view = UIView()
        addSubview(view)
        
        self.setupButtonImage()
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle  = Bundle(for: type(of: self))
        let nib     = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return nibView
    }
    
    private func setupButtonImage() {
        self.penButton.setImage(UIImage(named: "ic_pen")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.pencilButton.setImage(UIImage(named: "ic_pencil")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.markerButton.setImage(UIImage(named: "ic_marker")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.eraserButton.setImage(UIImage(named: "ic_erase")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.palleteButton.setImage(UIImage(named: "ic_pallete")?.withRenderingMode(.alwaysTemplate), for: .normal)
        
        self.palleteButton.tintColor = UIColor.white
        
        self.selectedButton = self.pencilButton
        
        self.resetTintColor()
    }
    
    private func resetTintColor() {
        self.penButton.tintColor        = UIColor.white
        self.pencilButton.tintColor     = UIColor.white
        self.markerButton.tintColor     = UIColor.white
        self.eraserButton.tintColor     = UIColor.white
    }

    @IBAction private func toolButtonSelected(sender: UIButton) {
        self.resetTintColor()
        sender.tintColor    = selectedColor
        self.selectedButton = sender
        
        switch sender {
        case self.penButton:
            delegate?.drawingToolSelected(type: .pen)
        case self.pencilButton:
            delegate?.drawingToolSelected(type: .pencil)
        case self.markerButton:
            delegate?.drawingToolSelected(type: .marker)
        case self.eraserButton:
            delegate?.drawingToolSelected(type: .eraser)
        default:
            break
        }
    }
    
    @IBAction private func palletButtonSelected(sender: UIButton) {
        if colorPallet != nil {
            self.dismissColorPallete()
        }
        
        colorPallet = UIView(frame: CGRect(x: 0, y: -self.palleteStack.frame.origin.y, width: self.frame.width, height: self.palleteStack.frame.origin.y))
        let colorHeight = (colorPallet.frame.size.height / CGFloat(colorArray.count)) - 2
        let colorWidth  = colorHeight
        for i in 0 ..< colorArray.count {
            let colorButton = UIButton(frame: CGRect(x: (colorPallet.frame.size.width - colorWidth) / 2, y: 6 + (CGFloat(i) * (colorHeight + 2)), width: colorWidth, height: colorHeight))
            colorButton.layer.cornerRadius = colorButton.frame.size.width / 2
            colorButton.backgroundColor = colorArray[i]
            colorButton.addTarget(self, action: #selector(colorSelected(_:)), for: .touchUpInside)
            colorPallet.addSubview(colorButton)
        }
        
        self.addSubview(colorPallet)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.colorPallet.frame.origin.y = 0
        }) { (completed) in
            self.penButton.alpha    = 0
            self.pencilButton.alpha = 0
            self.markerButton.alpha = 0
            self.eraserButton.alpha = 0
        }
    }
    
    private func dismissColorPallete() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.colorPallet.frame.origin.y = -(self.palleteStack.frame.origin.y + 6)
        }) { (completed) in
            self.colorPallet.removeFromSuperview()
            self.colorPallet        = nil
            self.penButton.alpha    = 1
            self.pencilButton.alpha = 1
            self.markerButton.alpha = 1
            self.eraserButton.alpha = 1
    
            return
        }
    }
    
    @objc private func colorSelected(_ sender: UIButton) {
        self.selectedColor = sender.backgroundColor!
        self.resetTintColor()
        
        self.selectedButton.tintColor   = self.selectedColor
        self.palleteButton.tintColor    = self.selectedColor
        
        self.dismissColorPallete()
        
        delegate?.newColorSelected(color: self.selectedColor)
    }
}

