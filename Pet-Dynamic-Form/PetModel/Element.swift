//
//  Element.swift
//  Pet-Clinic
//
//  Created by Achem Samuel on 6/25/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import Foundation

struct Element : Codable {
    let type : String?
    let label : String?
    let keyboard : String?
    let formattedNumeric : String?
    let mode : String?
    let file : String?
    let unique_id : String?
    let isMandatory : Bool?
    let rules : [Rule]?
    
    enum CodingKeys : String, CodingKey {
        case type =  "type"
        case label = "label"
        case file = "file"
        case unique_id = "unique_id"
        case keyboard = "keyboard"
        case formattedNumeric = "formattedNumeric"
        case mode = "mode"
        case rules = "rules"
        case isMandatory = "isMandatory"
    }
    
    init(from decoder : Decoder) throws {
        let elements = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try elements.decodeIfPresent(String.self, forKey: .type)
        self.label = try elements.decodeIfPresent(String.self, forKey: .label)
        self.file = try elements.decodeIfPresent(String.self, forKey: .file)
        self.unique_id = try elements.decodeIfPresent(String.self, forKey: .unique_id)
        self.keyboard = try elements.decodeIfPresent(String.self, forKey: .keyboard)
        self.formattedNumeric = try elements.decodeIfPresent(String.self, forKey: .formattedNumeric)
        self.mode = try elements.decodeIfPresent(String.self, forKey: .mode)
        self.isMandatory = try elements.decodeIfPresent(Bool.self, forKey: .isMandatory)
        self.rules = try elements.decodeIfPresent([Rule].self, forKey: .rules)
    }
}
