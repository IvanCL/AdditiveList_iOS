//
//  DetailItemController.swift
//  AdditiveList
//
//  Created by Ivan Cozar Laguna on 15/10/2019.
//  Copyright © 2019 Ivan Cozar Laguna. All rights reserved.
//

import UIKit

protocol DetailItemControllerDelegate {
    func wasTappedOkButton()
}


class DetailItemController: UIViewController {

    var delegate: DetailItemControllerDelegate?
    var product: Product?
    var additive: Additive?
    
    @IBOutlet weak var numbAdditive: UILabel!
    @IBOutlet weak var nameAdditive: UILabel!
    @IBOutlet weak var descriptionAdditive: UILabel!
    @IBOutlet weak var sideEffects: UILabel!
    @IBOutlet weak var additiveUses: UILabel!
    @IBOutlet weak var additiveOrigin: UILabel!
    @IBOutlet weak var additiveVegIcon: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productUses: UILabel!
    @IBOutlet weak var productOrigin: UILabel!
    @IBOutlet weak var productVegIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       
        if additive != nil {
            numbAdditive.text = additive?.numb
            nameAdditive.text = additive?.name
            descriptionAdditive.text = additive?.description
            sideEffects.text = additive?.sideEffects
            additiveUses.text = additive?.uses
            additiveOrigin.text = additive?.origin
            
            if additive?.origin.lowercased().elementsEqual("no vegano") == true{
                view.backgroundColor = .red
                additiveVegIcon.image = UIImage(named: "skull_icon")
            }else if additive?.origin.lowercased().elementsEqual("dudoso") == true{
                view.backgroundColor = .orange
                additiveVegIcon.image = UIImage(named: "question_icon")
            }
        }
        if product != nil {
               productName.text = product?.name
               productDescription.text = product?.description
               productUses.text = product?.uses
               productOrigin.text = product?.origin
            
            if product?.origin.lowercased().elementsEqual("no vegano") == true{
                view.backgroundColor = .red
                productVegIcon.image = UIImage(named: "skull_icon")
            }else if product?.origin.lowercased().elementsEqual("dudoso") == true{
                view.backgroundColor = .orange
                productVegIcon.image = UIImage(named: "question_icon")
            }
        }
    
 
    }
    
}
