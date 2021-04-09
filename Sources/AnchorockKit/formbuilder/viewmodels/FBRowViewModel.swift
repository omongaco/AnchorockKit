//
//  FBRowViewModel.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 3/13/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import Foundation
import UIKit

class FBRowViewModel {
    var title: String?
    var type: String
    var backgroundColor: UIColor = .white
    var contentLayout: NSLayoutConstraint.Axis = .horizontal
    var contents: [[FBFieldViewModel]]
    
    init(data: FBRow) {
        self.title = data.title
        self.type = data.type
        
        let hexColor = data.backgroundColor.replacingOccurrences(of: "#", with: "")
        self.backgroundColor = UIColor(hexString: hexColor)
        
        if data.contentLayout == "vertical" {
            self.contentLayout = .vertical
        }
        
        self.contents = [[FBFieldViewModel]]()
        for content in data.contents {
            let fieldArray = content.map{FBFieldViewModel(data: $0)}
            self.contents.append(fieldArray)
        }
    }
    
    func getObjectDictionary() -> [String: AnyObject] {
        var contentsDict = [[[String: AnyObject]]]()
        for content in contents {
            var fieldDict = [[String: AnyObject]]()
            for field in content {
                fieldDict.append(field.getObjectDictionary())
            }
            contentsDict.append(fieldDict)
        }
        
        return [
            "title": title != nil ? title! as AnyObject : "" as AnyObject,
            "type": type as AnyObject,
            "background_color": backgroundColor.toHexString() as AnyObject,
            "content_layout": contentLayout == .horizontal ? "horizontal" as AnyObject : "vertical" as AnyObject,
            "contents": contentsDict as AnyObject
        ]
    }
}
