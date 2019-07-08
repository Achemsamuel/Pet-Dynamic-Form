//
//  Page.swift
//  Pet-Clinic
//
//  Created by Achem Samuel on 6/25/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import Foundation

struct Page : Codable {
    let label : String?
    let sections : [Section]?
    
    enum CodngKeys: String, CodingKey {
        case label = "label"
        case sections = "sections"
    }
    
    init(from decoder : Decoder) throws {
        let pages = try decoder.container(keyedBy: CodingKeys.self)
        self.label = try pages.decodeIfPresent(String.self, forKey: .label)
        self.sections = try pages.decodeIfPresent([Section].self, forKey: .sections)
        
    }
}
