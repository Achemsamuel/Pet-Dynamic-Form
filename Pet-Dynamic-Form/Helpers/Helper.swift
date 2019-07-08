//
//  Helper.swift
//  Pet-Dynamic-Form
//
//  Created by Achem Samuel on 7/6/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import Foundation

enum ViewTypes : String, CodingKey {
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
