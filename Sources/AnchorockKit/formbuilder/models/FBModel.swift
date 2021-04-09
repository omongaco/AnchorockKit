//
//  FBModel.swift
//  Anchorock
//
//  Created by Ansyar Hafid on 2/23/20.
//  Copyright © 2020 Anchorock. All rights reserved.
//

import Foundation

// MARK: - FBModel
public struct FBModel: Codable {
    public let name, type: String
    public let backgroundColor, contentLayout: String
    public let contents: [FBSection]

    enum CodingKeys: String, CodingKey {
        case name, type
        case backgroundColor = "background_color"
        case contentLayout = "content_layout"
        case contents
    }
}

// MARK: - FBModelContent
public struct FBSection: Codable {
    public let title: String?
    public let type: String
    public let backgroundColor, contentLayout: String
    public let contents: [FBRow]

    enum CodingKeys: String, CodingKey {
        case title, type
        case backgroundColor = "background_color"
        case contentLayout = "content_layout"
        case contents
    }
}

// MARK: - FBSectionContent
public struct FBRow: Codable {
    public let title: String?
    public let type: String
    public let backgroundColor, contentLayout: String
    public let contents: [[FBField]]

    enum CodingKeys: String, CodingKey {
        case title, type
        case backgroundColor = "background_color"
        case contentLayout = "content_layout"
        case contents
    }
}

// MARK: - FBRowContent
public struct FBField: Codable {
    public let uid: String
    public let type, label: String
    public let placeholder: String
    public let contentDescription: String
    public let value: String
    public let options: [FBOptions]
    public let values: [FBValue]
    public let data: FBData
    public let validation: FBValidation
    public let display: FBDisplay
    public let buttons: [String]

    enum CodingKeys: String, CodingKey {
        case uid, type, label, placeholder
        case contentDescription = "description"
        case value, options, values, data, validation, display, buttons
    }
}

// MARK: - DataClass
public struct FBData: Codable {
    public let selected, value: String?

    enum CodingKeys: String, CodingKey {
        case selected, value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        selected = try container.decodeIfPresent(String.self, forKey: .selected)
        value = try container.decodeIfPresent(String.self, forKey: .value)
    }
}

// MARK: - Dispay
public struct FBDisplay: Codable {
    public let height, containedField: String?
    public let color, selectedColor: String?
    public let errorColor: String?
    public let backgroundColor: String?

    enum CodingKeys: String, CodingKey {
        case height, color
        case containedField = "contained_field"
        case selectedColor = "selected_color"
        case errorColor = "error_color"
        case backgroundColor = "background_color"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        height = try container.decodeIfPresent(String.self, forKey: .height)
        containedField = try container.decodeIfPresent(String.self, forKey: .containedField)
        color = try container.decodeIfPresent(String.self, forKey: .color)
        selectedColor = try container.decodeIfPresent(String.self, forKey: .selectedColor)
        errorColor = try container.decodeIfPresent(String.self, forKey: .errorColor)
        backgroundColor = try container.decodeIfPresent(String.self, forKey: .backgroundColor)
    }
}

// MARK: - Option
public struct FBOptions: Codable {
    public let uid, type, name, value: String?

    enum CodingKeys: String, CodingKey {
        case uid, type, name, value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uid = try container.decodeIfPresent(String.self, forKey: .uid)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        value = try container.decodeIfPresent(String.self, forKey: .value)
    }
}

// MARK: - FBValidation
public struct FBValidation: Codable {
    public let editable, validationRequired: String?
    public let minLength, maxLength, formats: String?

    enum CodingKeys: String, CodingKey {
        case editable
        case validationRequired = "required"
        case minLength = "min_length"
        case maxLength = "max_length"
        case formats
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        editable = try container.decodeIfPresent(String.self, forKey: .editable)
        validationRequired = try container.decodeIfPresent(String.self, forKey: .validationRequired)
        minLength = try container.decodeIfPresent(String.self, forKey: .minLength)
        maxLength = try container.decodeIfPresent(String.self, forKey: .maxLength)
        formats = try container.decodeIfPresent(String.self, forKey: .formats)
    }
}

// MARK: - Value
public struct FBValue: Codable {
    public let uid: String?
    public let type, name, value: String?

    enum CodingKeys: String, CodingKey {
        case uid, type, name, value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uid = try container.decodeIfPresent(String.self, forKey: .uid)
        type = try container.decodeIfPresent(String.self, forKey: .type)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        value = try container.decodeIfPresent(String.self, forKey: .value)
    }
}

