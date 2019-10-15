//
//  DataManager.swift
//  AdditiveList
//
//  Created by Ivan Cozar Laguna on 15/10/2019.
//  Copyright © 2019 Ivan Cozar Laguna. All rights reserved.
//

import Foundation
import GRDB

class DataManager{
    
    static let dataManager = DataManager()
    var dbQueue: DatabaseQueue?
    
    private init(){
        setupDataBase()
    }
    
    private func openDB() throws {
        let applicationSupportFolderUrl = try FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        
        let dbUrl = applicationSupportFolderUrl.appendingPathComponent("demoDB.sqlite")
        
        dbQueue = try DatabaseQueue(path: dbUrl.path)
    }
    
    func setupDataBase() {
        
        do {
            try openDB()
            
            guard let dbQueue = dbQueue else {
                return
            }
            
            //SQLITE
            try dbQueue.write({ db in
                
                try db.create(table: "Additive", temporary: false, ifNotExists: true, body: { t in
                    t.column("id").primaryKey()
                    t.column("numb")
                    t.column("name")
                    t.column("description")
                    t.column("uses")
                    t.column("sideEffects")
                    t.column("origin")
                })
            })
            
        }catch {
            print("Error al intentar crear la tabla Additive \(error)")
        }
    }
    
    
    func loadAdditives() -> [Additive]{
        
        guard let dbQueue = dbQueue else {
            return [Additive]()
        }
        
        do {
            return try dbQueue.read({ db -> [Additive] in
                try Additive.fetchAll(db, sql: "select * from Additive")
            })
            
        } catch {
            print("Error al intentar recuperar la tabla Additive \(error)")
        }
        
        return [Additive]()
    }
    
    func saveAdditive(_ additive: Additive){
        guard let dbQueue = dbQueue else {
            return
        }
        
        do {
                try dbQueue.write { db in
                    try additive.insert(db)
                }
            
        } catch {
            print("Error al intentar guardar la tabla Additive \(error)")
        }
        
    }
    
    
}
