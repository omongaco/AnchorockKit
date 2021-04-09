//
//  FBDataViewModel.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 3/13/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import Foundation

class FBDataViewModel {
    var selected: Bool
    var value: String?
    
    init(data: FBData) {
        selected = data.selected == "true" ? true : false
        value = data.value
    }
    
    func getObjectDictionary() -> [String: String] {
        return [
            "selected": selected.description,
            "value": value ?? ""
        ]
    }
}
