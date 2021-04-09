//
//  AROCKImageView.swift
//  AnchorockKit
//
//  Created by Ansyar Hafid on 4/10/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import UIKit


//  Markup Tool Enum Value
public enum AROCKMarkupType: String {
    case pencil = "pencil", pen = "pen", marker = "marker", eraser = "eraser"
    
    var description: String {
        get {
            return self.rawValue
        }
    }
}

@available(iOS 9.0, *)
public class AROCKImageView: UIView, AROCKMarkupToolsDelegate, UIScrollViewDelegate {
    //  Properties
    public var mScrollView: UIScrollView!
    public var canvas: AROCKCanvas!
    public var mImageView: UIImageView!
    public var markupTools: AROCKMarkupTools!
    public var selectedTool: AROCKMarkupType!
    public var isZoomed = false
    public var mImage: UIImage!
    public var imageName: String!
    
    public var exifData: [String: Any]?
    
    public init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        
        backgroundColor = .darkText
        self.mImage = image
        let globalFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.mScrollView = UIScrollView(frame: globalFrame)
        self.mScrollView.delegate = self
        self.mScrollView.contentSize = frame.size
        self.mScrollView.minimumZoomScale = 1.0
        self.mScrollView.maximumZoomScale = 5.0
        self.mScrollView.zoomScale = self.mScrollView.minimumZoomScale
        self.mScrollView.canCancelContentTouches = false
        self.mScrollView.delaysContentTouches = true
        
        if image.accessibilityIdentifier != nil {
            imageName = image.accessibilityIdentifier
        }

        self.mImageView = UIImageView(frame: self.mScrollView.bounds)
        self.mImageView.isUserInteractionEnabled = true
        self.mImageView.backgroundColor = UIColor.clear
        self.mImageView.contentMode = UIView.ContentMode.scaleAspectFit
        self.mImageView.image = image
        
        self.canvas = AROCKCanvas(frame: self.mImageView.bounds, markups: nil)
        self.canvas.isUserInteractionEnabled = true
        
        self.mImageView.addSubview(self.canvas)
        self.mScrollView.addSubview(self.mImageView)
        self.addSubview(mScrollView)
        
        markupTools = AROCKMarkupTools(frame: CGRect(x: 20, y: self.mScrollView.bounds.maxY - 205, width: 46, height: 185))
        markupTools.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        markupTools.layer.borderWidth = 0.5
        markupTools.layer.cornerRadius = 5
        markupTools.delegate = self
        
        self.addSubview(markupTools)
        
        if let exif = AROCKImageUtility.getMarkupsFromExif(image: image) {
            print("EXIF DATA: \(exif)")
            print("Identifier: \(String(describing: image.accessibilityIdentifier))")
        }
        
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func saveImageWithMarkup() {
        // Todo
    }
    
    public func drawingToolSelected(type: AROCKMarkupType) {
        self.canvas.markup.markupType = type
    }
    
    public func newColorSelected(color: UIColor) {
        canvas.markup.strokeColor = color
    }
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.mImageView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.isZoomed = self.mScrollView.zoomScale == self.mScrollView.minimumZoomScale ? false : true
    }
}

