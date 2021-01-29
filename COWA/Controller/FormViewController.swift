//
//  FormViewController.swift
//  COWA
//
//  Created by Lucas Deane on 11/28/20.
//

import UIKit

class FormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var AID: UITextField!
    @IBOutlet weak var SID: UITextField!
    @IBOutlet weak var VisitNum: UITextField!
    @IBOutlet weak var DatePicker: UIDatePicker!
    @IBOutlet weak var FormPicker: UIPickerView!
    
    let errorAID = "You must enter an AID. "
    let errorSID = "You must enter a SID. "
    let errorVisitNum = "You must enter a visit number. "
    var errorMessage = ""
    var someNull = false
    
    var formNum = 1
    var date = Date()
    
    let forms = [1, 2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AID.keyboardType = UIKeyboardType.decimalPad
        SID.keyboardType = UIKeyboardType.decimalPad
        VisitNum.keyboardType = UIKeyboardType.decimalPad
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Date Picker Handling
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        date = DatePicker.date
    }
    
    //MARK: - Form Picker Handling
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(forms[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return forms.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        formNum = forms[row]
    }
    
    //MARK: - Create Button Handling
    @IBAction func createRecord(_ sender: CustomButton) {
        errorMessage = ""
        if (AID.text == nil || AID.text == "") {
            errorMessage.append(errorAID)
            someNull = true
        }
                
        if (SID.text == nil || SID.text == "") {
            errorMessage.append(errorSID)
            someNull = true
        }
                
        if (VisitNum.text == nil || VisitNum.text == "") {
            errorMessage.append(errorVisitNum)
            someNull = true
        }
        
        if (!someNull) {
            let formatter = DateFormatter()
            formatter.calendar = DatePicker.calendar
            formatter.dateFormat = "MM/dd/yyyy' 'HH:mm"
            master.insert(Assessment(AID: AID.text!, SID: SID.text!, visitNum: Int(VisitNum.text ?? "1") ?? 1, visitDate: formatter.string(from: date), formNum: formNum)!, at: 0)
            currentAssessment = 0
            normalMode = true
            ableToEdit = true
            detailMode = false
            performSegue(withIdentifier: "formToDraw", sender: self)
        } else {
            let alert = UIAlertController(title: "Must Enter Value", message: errorMessage, preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
            someNull = false
        }
        detailMode = false
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
