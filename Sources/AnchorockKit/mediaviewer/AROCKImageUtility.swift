//
//  AROCKImageUtility.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 4/10/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import Foundation
import UIKit
import ImageIO

public class AROCKImageUtility {
    
    public static func getMarkupsFromExif(image: UIImage) -> [AROCKMarkup]? {
        var ret: [AROCKMarkup]?
        
        if let imageData = image.jpegData(compressionQuality: 1) {
            if let imageSource = CGImageSourceCreateWithData(imageData as CFData, nil) {
                let dataWithExif = NSMutableData(data: imageData)
                
                if let testImage = CIImage(data: dataWithExif as Data, options: nil) {
                    let properties = testImage.properties as NSDictionary
                    print("Markups: \(properties)")
                }
            }
        }
        
        return ret
    }
    
    public static func saveExifMakerNote(markups: [AROCKMarkup], image: UIImage) {
        var markupString: String?
        var markupDictionary = [[String: String]]()
        
        for markup in markups {
            let dict = [
                "markupType": markup.markupType.description,
                "markupColor": markup.strokeColor.description,
                "markupPoints": markup.drawPoints.description
            ]
            markupDictionary.append(dict)
        }
        
        do {
            let markupJson = try JSONSerialization.data(withJSONObject: markupDictionary, options: .prettyPrinted)
            markupString = String(data: markupJson, encoding: String.Encoding.utf8)
        } catch let error {
            print("JSON Error: \(error.localizedDescription)")
        }
        
        if let imageData = image.jpegData(compressionQuality: 1) {
            if let imageSource = CGImageSourceCreateWithData(imageData as CFData, nil) {
                let uti: CFString = CGImageSourceGetType(imageSource)!
                let dataWithExif = NSMutableData(data: imageData)
                
                if let destination = CGImageDestinationCreateWithData(dataWithExif as CFMutableData, uti, 1, nil) {
                    
                    let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil)! as NSDictionary
                    let mutable = imageProperties.mutableCopy() as! NSMutableDictionary
                    
                    let exifDictionary = (mutable[kCGImagePropertyExifDictionary as String] as? NSMutableDictionary)!
                    exifDictionary[kCGImagePropertyExifUserComment as String] = markupString!
                    mutable[kCGImagePropertyExifDictionary as String] = exifDictionary
                    
                    CGImageDestinationAddImageFromSource(destination, imageSource, 0, (mutable as CFDictionary))
                    let success = CGImageDestinationFinalize(destination)
                    
                    if success {
                        if let imageIdentifier = image.accessibilityIdentifier {
                            let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String + "/MediaFolder/\(imageIdentifier).jpg"
                            dataWithExif.write(toFile: documentPath, atomically: true)
                        } else {
                            let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String + "/MediaFolder/\(NSUUID().uuidString.lowercased()).jpg"
                            dataWithExif.write(toFile: documentPath, atomically: true)
                        }
                    }
                }
            }
        }
    }
    
}
