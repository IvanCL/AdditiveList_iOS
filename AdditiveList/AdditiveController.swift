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
        
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        additives = DataManager.dataManager.loadAdditives()
        //additiveTable.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if let detailItemController = segue.destination as? DetailItemController {
                detailItemController.additive = additiveSelected
                detailItemController.delegate = self
            }       
    }
    
    @IBAction func textChange(_ sender: UITextField) {
        if findAdditiveTxt != nil && findAdditiveTxt.text!.count >= 2{
                 if !additives.isEmpty {
                     findCoincidences()
                 }else{
                     getAdditivesFromDB()
                     findCoincidences()
                 }
                additiveTable.register(UITableViewCell.self, forCellReuseIdentifier: "itemAdditive")
                additiveTable.reloadData()
             }
    }
    

    private func findCoincidences(){
        additivesToShow.removeAll()
        for additive in additives{
            if (additive.numb.lowercased().starts(with: "e") && additive.numb.lowercased().contains( findAdditiveTxt.text!.lowercased())) || additive.name.lowercased().contains(findAdditiveTxt.text!.lowercased())  {
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
            return additivesToShow.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // El recibido
            var additive: Additive?
            if additivesToShow.isEmpty{
                additive = additives[indexPath.row]
            }else {
                additive = additivesToShow[indexPath.row]
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemAdditive", for: indexPath)
            
            cell.textLabel?.text = additive!.numb + " - " +  additive!.name
            
            if additive!.origin.lowercased().elementsEqual("no vegano") == true{
                cell.backgroundColor = .red
            }else if additive!.origin.lowercased().elementsEqual("dudoso") == true{
                cell.backgroundColor = .orange
            }else{
                cell.backgroundColor = .green
            }
            
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            additiveSelected = additivesToShow[indexPath.row]
            
            performSegue(withIdentifier: "itemDetailAdditive", sender: additiveSelected)
        }
    
        

        
}
    
extension AdditiveController: DetailItemControllerDelegate {
    
    func wasTappedOkButton() {
        /*students = DataManager.dataManager.loadStudents()
        studentTable.reloadData()*/
        
        dismiss(animated: true, completion: nil)
    }
    
    
}


