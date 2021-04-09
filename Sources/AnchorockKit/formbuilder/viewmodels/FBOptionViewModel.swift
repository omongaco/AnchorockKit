//
//  FBOptionViewModel.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 3/13/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import Foundation

class FBOptionViewModel {
    var uid: String?
    var type: String?
    var name: String?
    var value: String?
    
    init(){}
    
    init(uid: String?, type: String?, name: String?, value: String?) {
        self.uid = uid
        self.type = type
        self.name = name
        self.value = value
    }
    
    init(data: FBOptions) {
        uid = data.uid
        type = data.type
        name = data.name
        value = data.value
    }
    
    func getObjectDictionary() -> [String: String] {
        return [
            "uid": uid ?? "",
            "type": type ?? "",
            "name": name ?? "",
            "value": value ?? ""
        ]
    }
}
