//
//  ViewController.swift
//  AdditiveList
//
//  Created by Ivan Cozar Laguna on 04/09/2019.
//  Copyright © 2019 Ivan Cozar Laguna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var additives = [Additive]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //additives = DataManager.dataManager.loadAdditives()
        getAdditives()

                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        additives = DataManager.dataManager.loadAdditives()
        //studentTable.reloadData()
    }

    func getAdditives(){
        let additiveURL = URL(string: "https://muuvegan.herokuapp.com/additives/")!
        
        let task = URLSession.shared.dataTask(with: additiveURL){ (data, response, error) in
      guard let dataResponse = data,
                   error == nil else {
                   print(error?.localizedDescription ?? "Response Error")
                   return }
             do {
                 //here dataResponse received from a network request
                 let decoder = JSONDecoder()
                 let model = try decoder.decode([Additive].self, from:
                              dataResponse) //Decode JSON Response Data
                print(model[0].numb)
                for additive in model {
                    print("\(additive.numb)")
                    DataManager.dataManager.saveAdditive(additive)
                }
             } catch let parsingError {
                 print("Error", parsingError)
             }
            
        }
        task.resume()
        
        
    }
    
}

