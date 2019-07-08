//
//  Section.swift
//  Pet-Clinic
//
//  Created by Achem Samuel on 6/25/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import Foundation

struct Section : Codable {
    let label : String?
    let elements : [Element]?
    
    enum CodingKeys : String, CodingKey {
        case label = "label"
        case elements = "elements"
    }
    
    init(from decoder : Decoder) throws {
        let elements = try decoder.container(keyedBy: CodingKeys.self)
        self.label = try elements.decodeIfPresent(String.self, forKey: .label)
        self.elements = try elements.decodeIfPresent([Element].self, forKey: .elements)
    }
    
}
