//
//  Product.swift
//  AdditiveList
//
//  Created by Ivan Cozar Laguna on 15/10/2019.
//  Copyright © 2019 Ivan Cozar Laguna. All rights reserved.
//

import Foundation
import GRDB


struct Product {
    let id: String
    let name: String
    let description: String
    let uses: String
    let origin: String
    
}

extension Product: FetchableRecord, PersistableRecord{
    func encode(to container: inout PersistenceContainer) {
        container["id"] = id
        container["name"] = name
        container["description"] =   description
        container["uses"] = uses
        container["origin"] = origin
    }
    
    init(row: Row){
        id = row["id"]
        name = row["name"]
        description = row["description"]
        uses = row["uses"]
        origin = row["origin"]
    }
    
}

