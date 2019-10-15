//
//  Product.swift
//  AdditiveList
//
//  Created by Ivan Cozar Laguna on 15/10/2019.
//  Copyright © 2019 Ivan Cozar Laguna. All rights reserved.
//

import Foundation
import GRDB


struct Product: Codable {
    let name: String
    let description: String
    let uses: String
    let origin: String
    
}

extension Product: FetchableRecord, PersistableRecord{
    func encode(to container: inout PersistenceContainer) {
        container["name"] = name
        container["description"] =   description
        container["uses"] = uses
        container["origin"] = origin
    }
    
    init(row: Row){
        name = row["name"]
        description = row["description"]
        uses = row["uses"]
        origin = row["origin"]
    }
    
    init(_ dictionary: [String: Any]){
        name = dictionary["name"] as! String
        description = dictionary["description"] as! String
        uses = dictionary["uses"] as! String
        origin = dictionary["origin"] as! String
    }
    
}

