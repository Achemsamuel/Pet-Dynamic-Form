//
//  NetworkManager.swift
//  Pet-Clinic
//
//  Created by Achem Samuel on 6/25/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import Foundation

let decoder = JSONDecoder()
class Parsejson {
    
    public func getPetJsonData (onComplete : (Pet)-> Void) {
        
        guard let path = Bundle.main.path(forResource: "pet_adoption", ofType: "json") else {
            return
        }
        
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            
            let json = try decoder.decode(Pet.self, from: data)
            onComplete(json)
        } catch {
            print("Could not get data :\(error.localizedDescription)")
        }
    }
}
