//
//  AROCKDatePicker.swift
//  AnchorockKit
//
//  Created by Ansyar hafid on 09/01/21.
//

import UIKit

public class AROCKDatePicker: UITextField, UITextFieldDelegate {
    public var selectedDate = Date()
    var timeFormat = false
    var dateFormatter = DateFormatter()
    
    public init(frame: CGRect, timestamp: Int = 0, timeFormat: Bool = false) {
        super.init(frame: frame)
        self.timeFormat = timeFormat
        
        if timestamp > 0 {
            self.selectedDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
        }
        
        postInit()
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        postInit()
    }
    
    func postInit() {
        delegate = self
        borderStyle = .roundedRect
        font = UIFont(name: "TrebuchetMS", size: 14)
        textColor = UIColor.darkGray
        inputAccessoryView = UIView()
        
        let doneButton = UIBarButtonItem(title: "DONE", style: .done, target: self, action: #selector(dismissPicker(_:)))
        
        if #available(iOS 9.0, *) {
            let barItemGroup = UIBarButtonItemGroup(barButtonItems: [doneButton], representativeItem: nil)
            inputAssistantItem.trailingBarButtonGroups.append(barItemGroup)
            inputAssistantItem.leadingBarButtonGroups.removeAll()
        }
        
        
        if #available(iOS 13.0, *) {
            if timeFormat {
                if let clockImage = UIImage(systemName: "clock") {
                    self.customRightView(image: clockImage)
                }
            } else {
                if let calendarImage = UIImage(systemName: "calendar") {
                    self.customRightView(image: calendarImage)
                }
            }
            
        }
    }
    
    func customRightView(image: UIImage) {
        let rightImage = UIImageView(image: image)
        rightImage.tintColor = .lightGray
        rightImage.contentMode = .scaleAspectFit
        
        self.rightView = rightImage
        self.rightViewMode = .always
        
        if #available(iOS 9.0, *) {
            rightImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        }
    }
    
    func configure() {
        if timeFormat {
            dateFormatter.dateFormat = "hh:mm a"
        } else {
            dateFormatter.dateFormat = "MMM dd, yyyy"
        }
        
        self.text = dateFormatter.string(from: selectedDate)
    }
    
    @objc func dismissPicker(_ sender:UIBarButtonItem) {
        if text == "" {
            text = dateFormatter.string(from: selectedDate)
        }
        
        resignFirstResponder()
    }
    
    @objc func dateHandler(_ sender:UIDatePicker) {
        selectedDate = sender.date
        text = dateFormatter.string(from: selectedDate)
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let datePicker = UIDatePicker()
        
        if #available(iOS 14.0, *) {
            if timeFormat {
                datePicker.preferredDatePickerStyle = .wheels
            } else {
                datePicker.preferredDatePickerStyle = .wheels
            }
        }
        
        datePicker.date = selectedDate
        textField.inputView = datePicker
        
        if timeFormat {
            datePicker.datePickerMode = .time
        } else {
            datePicker.datePickerMode = .date
        }
        
        datePicker.addTarget(self, action: #selector(dateHandler(_:)), for: .valueChanged)
        
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}
