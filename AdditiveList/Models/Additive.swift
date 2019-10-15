//
//  Additive.swift
//  AdditiveList
//
//  Created by Ivan Cozar Laguna on 15/10/2019.
//  Copyright © 2019 Ivan Cozar Laguna. All rights reserved.
//

import Foundation
import GRDB

struct Additive: Codable{
    let id: String
    let numb: String
    let name: String
    let description: String
    let uses: String
    let sideEffects: String
    let origin: String
    
}

extension Additive: FetchableRecord, PersistableRecord{
    func encode(to container: inout PersistenceContainer) {
        container["id"] = id
        container["numb"] = numb
        container["name"] = name
        container["description"] =   description
        container["uses"] = uses
        container["sideEffects"] = sideEffects
        container["origin"] = origin
    }
    
    init(row: Row){
        id = row["id"]
        numb = row["numb"]
        name = row["name"]
        description = row["description"]
        uses = row["uses"]
        sideEffects = row["sideEffects"]
        origin = row["origin"]
    }
    
    init(_ dictionary: [String: Any]){
        id = dictionary["id"] as! String
        numb = dictionary["numb"] as! String
        name = dictionary["name"] as! String
        description = dictionary["description"] as! String
        uses = dictionary["uses"] as! String
        sideEffects = dictionary["sideEffects"] as! String
        origin = dictionary["origin"] as! String
    }
}
