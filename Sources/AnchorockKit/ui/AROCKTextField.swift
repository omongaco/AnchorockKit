//
//  AROCKTextField.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 3/11/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import UIKit

public class AROCKTextField: UITextField {
    
    var fontSize = CGFloat(14)
    var fontColor = UIColor.darkGray
    
    public init(frame: CGRect, size:CGFloat, color: UIColor) {
        super.init(frame: frame)
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
    }
    
}
