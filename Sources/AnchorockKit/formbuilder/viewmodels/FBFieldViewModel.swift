//
//  FBFieldViewModel.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 3/13/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import Foundation
import UIKit

class FBFieldViewModel {
    var uid: String?
    var type: FBFieldType
    var label: String
    var placeholder: String
    var description: String
    var value: String
    var options: [FBOptionViewModel]
    var values: [FBValueViewModel]
    var data: FBDataViewModel
    var validation: FBValidationViewModel
    var display: FBDisplayViewModel
    var buttons: [String]
    
    init(data: FBField) {
        self.uid = data.uid
        self.type = FBFieldType(rawValue: data.type)!
        self.label = data.label
        self.placeholder = data.placeholder
        self.description = data.contentDescription
        self.value = data.value
        self.options = data.options.map{FBOptionViewModel(data:$0)}
        self.values = data.values.map{FBValueViewModel(data: $0)}
        self.data = FBDataViewModel(data: data.data)
        self.validation = FBValidationViewModel(data: data.validation)
        self.display = FBDisplayViewModel(data: data.display)
        self.buttons = data.buttons
    }
    
    func getObjectDictionary() -> [String: AnyObject] {
        // Build options dictionary
        var optionsDict = [[String: String]]()
        for option in options {
            optionsDict.append(option.getObjectDictionary())
        }
        
        // Build values dictionary
        var valuesDict = [[String: String]]()
        for value in values {
            valuesDict.append(value.getObjectDictionary())
        }
        
        return [
            "uid": uid != nil ? uid as AnyObject : "" as AnyObject,
            "type": type as AnyObject,
            "label": label as AnyObject,
            "placeholder": placeholder as AnyObject,
            "description": description as AnyObject,
            "value": value as AnyObject,
            "options": optionsDict as AnyObject,
            "values": valuesDict as AnyObject,
            "data": data.getObjectDictionary() as AnyObject,
            "validation": validation.getObjectDictionary() as AnyObject,
            "display": display.getObjectDictionary() as AnyObject,
            "buttons": buttons as AnyObject
        ]
    }
   
}
