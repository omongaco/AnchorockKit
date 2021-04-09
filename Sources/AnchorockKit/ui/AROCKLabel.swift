//
//  AROCKLabel.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 3/11/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import UIKit

public class AROCKLabel: UILabel {
    var size = CGFloat(14)
    var color = UIColor.darkGray
    
    public init(frame: CGRect, size: CGFloat, color: UIColor) {
        super.init(frame: frame)
        self.size = size
        self.color = color
        postInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        postInit()
    }
    
    private func postInit() {
        font = UIFont(name: "TrebuchetMS", size: self.size)
        textColor = color
    }
}
