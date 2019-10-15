//
//  AdditiveController.swift
//  AdditiveList
//
//  Created by Ivan Cozar Laguna on 15/10/2019.
//  Copyright © 2019 Ivan Cozar Laguna. All rights reserved.
//

import UIKit

class AdditiveController: UIViewController {

    var additives = [Additive]()
    var additivesToShow = [Additive]()
    var additiveSelected: Additive?
    
    @IBOutlet weak var findAdditiveTxt: UITextField!
    @IBOutlet weak var additiveTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAdditivesFromDB()
        additiveTable.register(UITableViewCell.self, forCellReuseIdentifier: "itemAdditive")
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        additives = DataManager.dataManager.loadAdditives()
        additiveTable.reloadData()
    }

    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        print("Escribiendo")
        if findAdditiveTxt.text!.count > 2{
             if !additives.isEmpty {
                 findCoincidences()
             }else{
                 getAdditivesFromDB()
                 findCoincidences()
             }
         }
    }
    private func findCoincidences(){
        for additive in additives{
            if additive.numb.lowercased().contains(findAdditiveTxt.text!.lowercased()) || additive.numb.lowercased().contains("e" + findAdditiveTxt.text!.lowercased()) || additive.name.lowercased().contains(findAdditiveTxt.text!.lowercased())  {
                additivesToShow.append(additive)
                
            }
        }
    }
    
    func getAdditivesFromDB(){
        additives = DataManager.dataManager.loadAdditives()
    }
}
    extension AdditiveController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return additives.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // El recibido
            let additive = additives[indexPath.row]
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemAdditive", for: indexPath)
            
            cell.textLabel?.text = additive.description
            
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            additiveSelected = additives[indexPath.row]
            
            performSegue(withIdentifier: "itemDetailAdditive", sender: nil)
        }
        
        
    }
    


