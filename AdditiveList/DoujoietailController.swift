//
//  DetailController.swift
//  AdditiveList
//
//  Created by Ivan Cozar Laguna on 15/10/2019.
//  Copyright © 2019 Ivan Cozar Laguna. All rights reserved.
//

import UIKit

protocol DetailControllerDelegate {
    func wasTappedOkButton()
}


class DetailController: UIViewController {

    var delegate: DetailControllerDelegate?
    var product: Product?
    var additive: Additive?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Asi nos aseguramos de que no sea null
        guard let additive = additive else {
            return
        }
        
        guard let product = product else {
            return
        }
        
      /*  enrollmentTxt.text = student.enrolment
        nameTxt.text = student.name
        apellido.text = student.surname
        ageTxt.text = "\(student.age)"
        approvedSwich.isOn = student.approved*/
 
    }

    /*@IBAction func addStudent(_ sender: Any) {
        
        guard let enrolmentT = enrollmentTxt.text, !enrolmentT.isEmpty, let name = nameTxt.text , !name.isEmpty else {
            delegate?.wasTappedOkButton()
            return}
        
            
            let age = Int(ageTxt.text ?? "0") ?? 0
            
        let studentEdited = Student(name: name, surname: apellido.text ?? "", age: age , approved: approvedSwich.isOn, enrolment: enrolmentT)
            
            DataManager.dataManager.saveStudent(studentEdited)
        
        
        delegate?.wasTappedOkButton()
        
    }*/
    
}


