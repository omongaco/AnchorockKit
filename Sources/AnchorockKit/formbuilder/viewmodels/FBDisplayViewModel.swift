//
//  FBDisplayViewModel.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 3/13/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import Foundation
import UIKit

class FBDisplayViewModel {
    var height: String?
    var color: UIColor = .darkGray
    var selectedColor: UIColor = AROCKCOLOR.anchoGreen
    var errorColor: UIColor = .red
    var containedField = false
    var backgroundColor: UIColor = .white
    
    init(data: FBDisplay) {
        height = data.height
        
        if let containedFieldString = data.containedField {
            self.containedField = Bool(containedFieldString)!
        }
        
        if let colorString = data.color  {
            let hexColor = colorString.replacingOccurrences(of: "#", with: "")
            color = UIColor(hexString: hexColor)
        }
        
        if let colorString = data.selectedColor {
            let hexColor = colorString.replacingOccurrences(of: "#", with: "")
            color = UIColor(hexString: hexColor)
        }
        
        if let colorString = data.errorColor {
            let hexColor = colorString.replacingOccurrences(of: "#", with: "")
            color = UIColor(hexString: hexColor)
        }
        
        if let colorString = data.backgroundColor {
            let hexColor = colorString.replacingOccurrences(of: "#", with: "")
            backgroundColor = UIColor(hexString: hexColor)
        }
    }
    
    func getObjectDictionary() -> [String: String] {
        return [
            "height": height ?? "",
            "color": color.toHexString(),
            "selected_color": selectedColor.toHexString(),
            "error_color": errorColor.toHexString(),
            "contained_field": containedField.description,
            "background_color": backgroundColor.toHexString()
        ]
    }
}
