//
//  DetailViewController.swift
//  COWA
//
//  Created by Lucas Deane on 12/17/20.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var AIDLabel: UILabel!
    @IBOutlet weak var SIDLabel: UILabel!
    @IBOutlet weak var VisitNumLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var FormNumLabel: UILabel!
    @IBOutlet weak var T1RLabel: UILabel!
    @IBOutlet weak var T1ELabel: UILabel!
    @IBOutlet weak var T1TLabel: UILabel!
    @IBOutlet weak var T2RLabel: UILabel!
    @IBOutlet weak var T2ELabel: UILabel!
    @IBOutlet weak var T2TLabel: UILabel!
    @IBOutlet weak var T3RLabel: UILabel!
    @IBOutlet weak var T3ELabel: UILabel!
    @IBOutlet weak var T3TLabel: UILabel!
    @IBOutlet weak var SumRLabel: UILabel!
    @IBOutlet weak var SumELabel: UILabel!
    @IBOutlet weak var SumTLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        AIDLabel.text = "AID: \(selectedAssessment?.AID ?? "None")"
        SIDLabel.text = "SID: \(selectedAssessment?.SID ?? "None")"
        VisitNumLabel.text = "Visit #: \(selectedAssessment?.visitNum.description ?? "None")"
        DateLabel.text = "Date: \(selectedAssessment?.visitDate ?? "None")"
        FormNumLabel.text = "Form #: \(selectedAssessment?.formNum.description ?? "None")"
        T1RLabel.text = "T1R: \(selectedAssessment!.T1R.description)"
        T1ELabel.text = "T1E: \(selectedAssessment!.T1E.description)"
        T1TLabel.text = "T1T: \(selectedAssessment!.T1T.description)"
        T2RLabel.text = "T2R: \(selectedAssessment!.T2R.description)"
        T2ELabel.text = "T2E: \(selectedAssessment!.T2E.description)"
        T2TLabel.text = "T2T: \(selectedAssessment!.T2T.description)"
        T3RLabel.text = "T3R: \(selectedAssessment!.T3R.description)"
        T3ELabel.text = "T3E: \(selectedAssessment!.T3E.description)"
        T3TLabel.text = "T3T: \(selectedAssessment!.T3T.description)"
        SumRLabel.text = "Sum R: \(selectedAssessment!.sumR.description)"
        SumELabel.text = "Sum E: \(selectedAssessment!.sumE.description)"
        SumTLabel.text = "Sum T: \(selectedAssessment!.sumT.description)"
        
    }
    
    @IBAction func viewPanelPressed(_ sender: UIButton) {
        ableToEdit = false
        normalMode = false
        detailMode = true
        for i in 0...(master.count - 1) {
            if (master[i].AID == selectedAssessment?.AID) {
                detailAssessment = i
            }
        }
        performSegue(withIdentifier: "detailToDraw", sender: self)
    }
    

}
