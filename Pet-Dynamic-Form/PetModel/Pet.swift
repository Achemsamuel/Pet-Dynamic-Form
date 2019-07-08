//
//  Pet.swift
//  Pet-Clinic
//
//  Created by Achem Samuel on 6/25/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import Foundation

struct Pet : Codable {
    let id : String?
    let name : String?
    let pages : [Page]?
    
    enum CodngKeys : String, CodingKey {
        case id = "id"
        case name = "name"
        case pages = "pages"
    }
    
    init(from decoder : Decoder) throws {
        let pet = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try pet.decodeIfPresent(String.self, forKey: .id)
        self.name = try pet.decodeIfPresent(String.self, forKey: .name)
        self.pages = try pet.decodeIfPresent([Page].self, forKey: .pages)
    }
}
