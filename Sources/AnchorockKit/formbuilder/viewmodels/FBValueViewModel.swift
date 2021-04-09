//
//  FBValueViewModel.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 3/13/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import Foundation

class FBValueViewModel {
    var uid: String?
    var type: FBValueType?
    var name: String?
    var value: String?
    
    init(){}
    
    init(uid: String?, type: String?, name: String?, value: String?) {
        self.uid = uid
        if type != nil {
            self.type = FBValueType(rawValue: type!)
        }
        self.name = name
        self.value = value
    }
    
    init(data: FBValue) {
        uid = data.uid
        if data.type != nil {
            type = FBValueType(rawValue: data.type!)
        }
        name = data.name
        value = data.value
    }
    
    func getObjectDictionary() -> [String:String] {
        return [
            "uid": uid ?? "",
            "type": type?.toString() ?? "",
            "name": name ?? "",
            "value": value ?? ""
        ]
    }
}
