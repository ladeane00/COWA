//
//  ViewController.swift
//  COWA
//
//  Created by Lucas Deane on 11/1/20.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*master.append(Assessment(AID: "12351", SID: "1", visitNum: 1, visitDate: "Test", formNum: 1)!)
        master.append(Assessment(AID: "12352", SID: "124", visitNum: 2, visitDate: Date().description, formNum: 1)!)
        master.append(Assessment(AID: "12353", SID: "15", visitNum: 2, visitDate: Date().description, formNum: 2)!)
        master.append(Assessment(AID: "12354", SID: "1", visitNum: 1, visitDate: "Test", formNum: 1)!)
        master.append(Assessment(AID: "12355", SID: "124", visitNum: 2, visitDate: Date().description, formNum: 2)!)
        master.append(Assessment(AID: "12356", SID: "15", visitNum: 2, visitDate: Date().description, formNum: 1)!)
        master.append(Assessment(AID: "12357", SID: "1", visitNum: 1, visitDate: "Test", formNum: 2)!)
        master.append(Assessment(AID: "12358", SID: "124", visitNum: 2, visitDate: Date().description, formNum: 1)!)
        master.append(Assessment(AID: "12359", SID: "115", visitNum: 2, visitDate: Date().description, formNum: 2)!)*/
        
        print("Test")
        print(master.count)
        
    }

    @IBAction func currentButtonPressed(_ sender: CustomButton) {
        if (currentAssessment >= 0) {
            normalMode = true
            ableToEdit = true
            detailMode = false
            performSegue(withIdentifier: "drawSegue", sender: self)
        } else {
            let alert = UIAlertController(title: "Current Assessment Error", message: "You must create an assessment to go to current assessment", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
        }
    }
    

}

