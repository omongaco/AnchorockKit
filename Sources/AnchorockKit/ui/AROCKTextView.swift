//
//  AROCKTextView.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 5/3/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import UIKit

public class AROCKTextView: UITextView {
    
    var fontSize = CGFloat(14)
    var fontColor = UIColor.darkGray
    
    public init(frame: CGRect, size:CGFloat, color: UIColor) {
        super.init(frame: frame, textContainer: .none)
        self.fontSize = size
        self.fontColor = color
        postInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func postInit() {
        font = UIFont(name: "TrebuchetMS", size: fontSize)
        textColor = fontColor
        layer.cornerRadius = 5
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
}
