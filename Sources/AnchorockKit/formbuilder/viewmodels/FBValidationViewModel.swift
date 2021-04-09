//
//  FBValidationViewModel.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 3/13/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import Foundation

class FBValidationViewModel {
    var editable: Bool
    var required: Bool
    var minLength: Int?
    var maxLength: Int?
    var formats: formatType?
    
    enum formatType: String {
        case alphanumerics = "alphanumerics"
        case numbers = "numbers"
        case date = "MMM dd, yyyy"
        case time = "hh:mm a"
        
        func toString() -> String? {
            switch self {
            case .alphanumerics:
                return "alphanumerics"
                
            case .numbers:
                return "numbers"
                
            case .date:
                return "MMM dd, yyyy"
                
            case .time:
                return "hh:mm a"
            }
        }
    }
    
    init(data: FBValidation) {
        editable = data.editable == "true" ? true : false
        required = data.validationRequired == "false" ? true : false
        
        if let minLengthString = data.minLength, let minLengthRaw = Int(minLengthString) {
            minLength = minLengthRaw
        }
        
        if let maxLengthString = data.maxLength, let maxLengthRaw = Int(maxLengthString) {
            maxLength = maxLengthRaw
        }
        
        if let dataFormat = data.formats {
            formats = formatType(rawValue: dataFormat)
        }
    }
    
    func getObjectDictionary() -> [String: String] {
        return [
            "editable": editable.description,
            "required": required.description,
            "min_length": minLength?.description ?? "",
            "max_length": maxLength?.description ?? "",
            "formats": formats?.toString() ?? ""
        ]
    }
}
