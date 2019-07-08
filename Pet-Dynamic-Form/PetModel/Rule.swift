//
//  Rule.swift
//  Pet-Clinic
//
//  Created by Achem Samuel on 6/25/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import Foundation

struct Rule : Codable {
    let condition : String?
    let value : String?
    let action : String?
    let otherwise : String?
    let target : [String]?
    
    enum CodingKeys : String, CodingKey {
        case condition = "condition"
        case value = "value"
        case action = "action"
        case otherwise = "otherwise"
        case target = "targets"
    }
    
    init(from decoder : Decoder) throws {
        let rules = try decoder.container(keyedBy: CodingKeys.self)
        self.condition = try rules.decodeIfPresent(String.self, forKey: .condition)
        self.value = try rules.decodeIfPresent(String.self, forKey: .value)
        self.action = try rules.decodeIfPresent(String.self, forKey: .action)
        self.otherwise = try rules.decodeIfPresent(String.self, forKey: .otherwise)
        self.target = try rules.decodeIfPresent([String].self, forKey: .target)
    }
}
