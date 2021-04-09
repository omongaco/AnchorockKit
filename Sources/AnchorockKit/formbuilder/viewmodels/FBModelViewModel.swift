//
//  FBModelViewModel.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 3/13/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import Foundation
import UIKit

class FBModelViewModel {
    
    var name: String?
    var type: String
    var backgroundColor: UIColor = .white
    var contentLayout: NSLayoutConstraint.Axis = .horizontal
    var contents: [FBSectionViewModel]
    
    private var formBuilderModel: FBModel?
    
    init(data: FBModel) {
        self.name = data.name
        self.type = data.type
        
        let hexColor = data.backgroundColor.replacingOccurrences(of: "#", with: "")
        self.backgroundColor = UIColor(hexString: hexColor)
        
        if data.contentLayout == "vertical" {
            self.contentLayout = .vertical
        }
        
        self.contents = data.contents.map{FBSectionViewModel(data: $0)}
    }
    
    func getObjectDictionary() -> [String: AnyObject] {
        var contentsDict = [[String: AnyObject]]()
        for content in contents {
            contentsDict.append(content.getObjectDictionary())
        }
        
        return [
            "name": name != nil ? name! as AnyObject : "" as AnyObject,
            "type": type as AnyObject,
            "background_color": backgroundColor.toHexString() as AnyObject,
            "content_layout": contentLayout == .horizontal ? "horizontal" as AnyObject : "vertical" as AnyObject,
            "contents": contentsDict as AnyObject
        ]
    }
}
