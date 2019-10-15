//
//  ProductsController.swift
//  AdditiveList
//
//  Created by Ivan Cozar Laguna on 15/10/2019.
//  Copyright © 2019 Ivan Cozar Laguna. All rights reserved.
//

import UIKit

class ProductsController: UIViewController {

    var products = [Product]()
    var productsToShow = [Product]()
    var productSelected: Product?
    
    @IBOutlet weak var findProductTxt: UITextField!
    @IBOutlet weak var productTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProducts()
        productTable.register(UITableViewCell.self, forCellReuseIdentifier: "itemProduct")
                
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getProducts()
        productTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if let detailItemController = segue.destination as? DetailItemController {
                detailItemController.product = productSelected
                detailItemController.delegate = self
            }
    }

    
    @IBAction func textChange(_ sender: UITextField) {
        if findProductTxt != nil && findProductTxt.text!.count > 2{
            if !products.isEmpty {
                findCoincidences()
            }else{
                getProducts()
                findCoincidences()
            }
           productTable.register(UITableViewCell.self, forCellReuseIdentifier: "itemProduct")
           productTable.reloadData()
        }
    }
    

    private func findCoincidences(){
        productsToShow.removeAll()
        for product in products{
            if product.name.lowercased().contains(findProductTxt.text!.lowercased())  {
                productsToShow.append(product)
                
            }
        }
    }
    
    func getProducts(){
           
           if products.isEmpty {
               let productsURL = URL(string: "https://muuvegan.herokuapp.com/products/product/all")!
               
               let task = URLSession.shared.dataTask(with: productsURL){ (data, response, error) in
             guard let dataResponse = data,
                          error == nil else {
                          print(error?.localizedDescription ?? "Response Error")
                          return }
                    do {
                        let decoder = JSONDecoder()
                        self.products = try decoder.decode([Product].self, from:
                                     dataResponse) //Decode JSON Response Data
              
                    } catch let parsingError {
                        print("Error", parsingError)
                    }
                   
               }
               task.resume()
           }
           
       }
}
    extension ProductsController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return productsToShow.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // El recibido
          var product: Product?
            if productsToShow.isEmpty{
                product = products[indexPath.row]
            }else {
                product = productsToShow[indexPath.row]
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemProduct", for: indexPath)
            
            cell.textLabel?.text = product!.description
            
            if product!.origin.lowercased().elementsEqual("no vegano") == true{
                cell.backgroundColor = .red
            }else if product!.origin.lowercased().elementsEqual("dudoso") == true{
                cell.backgroundColor = .orange
            }else{
                cell.backgroundColor = .green
            }
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            productSelected = productsToShow[indexPath.row]
            
            performSegue(withIdentifier: "itemDetailProduct", sender: nil)
        }
        
        
    }
    

extension ProductsController: DetailItemControllerDelegate {
    
    func wasTappedOkButton() {
        /*students = DataManager.dataManager.loadStudents()
        studentTable.reloadData()*/
        
        dismiss(animated: true, completion: nil)
    }
    
    
}
