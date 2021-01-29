//
//  DrawViewController.swift
//  COWA
//
//  Created by Lucas Deane on 12/1/20.
//

import UIKit
import AVFoundation

class DrawViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var colorCollectionView: UICollectionView!
    
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    
    
    @IBOutlet weak var responseStepper: UIStepper!
    @IBOutlet weak var errorStepper: UIStepper!
    
    @IBOutlet weak var stateController: UISegmentedControl!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var editButton: CustomButton!
    @IBOutlet weak var homeButton: UIButton!
    
    
    var formOne = ["INSTRUCTIONS", "F", "A", "S"]
    var formTwo = ["INSTRUCTIONS", "C", "F", "L"]
    
    //Timer Initiations
    var timer: Timer?
    var startingTime = 62
    var timeLeft = 0
    
    //Audio Player Initiation
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Logic
        
        if (normalMode) {
            assessment = currentAssessment
            editButton.isHidden = true
            editButton.isEnabled = false
            homeButton.setTitle("Home", for: .normal)
            
        } else if (detailMode) {
            assessment = detailAssessment
            editButton.isHidden = false
            editButton.isEnabled = true
            homeButton.setTitle("Back", for: .normal)
        } else {
            print("Something went wrong with assessment handling.")
            homeButton.setTitle("Back", for: .normal)
        }
        
        navBar.topItem?.title = "AID: \(master[assessment].AID)"
        
        for i in master {
            print(i.T1R)
        }
        
        if (master[assessment].formNum == 1) {
            currentForm = formOne
        } else if (master[assessment].formNum == 2) {
            currentForm = formTwo
        }
        state = currentForm[0]
        
        for i in 0...(currentForm.count - 1) {
            stateController.setTitle(currentForm[i], forSegmentAt: i)
        }
        
        timeLeft = startingTime
        timerLabel.text = "\(timeLeft - 2)"
        
        colorCollectionView.delegate = self
        colorCollectionView.dataSource = self
        
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    //MARK: - State Control
    @IBAction func stateControllerPressed(_ sender: UISegmentedControl) {
        let selected = sender.selectedSegmentIndex
        state = currentForm[selected]
        pageNumber = 1
        updatePageLabel()
        
        if state != "INSTRUCTIONS" {
            infoLabel.isHidden = true
        } else {
            infoLabel.isHidden = false
        }
        
        switch selected {
        case 0:
            responseLabel.text = "0"
            errorLabel.text = "0"
            totalLabel.text = "0"
            canvasView.canDraw = false
            canvasView.lines = [TouchPointAndColor]()
            canvasView.tempLines = [TouchPointAndColor]()
            canvasView.setNeedsDisplay()
        case 1:
            responseStepper.value = Double(master[assessment].T1R)
            errorStepper.value = Double(master[assessment].T1E)
            responseLabel.text = String(master[assessment].T1R)
            errorLabel.text = String(master[assessment].T1E)
            totalLabel.text = String(master[assessment].T1T)
            
            canvasView.canDraw = true
            canvasView.lines = master[assessment].lines1[pageNumber - 1]
            canvasView.tempLines = master[assessment].tempLines1[pageNumber - 1]
            canvasView.setNeedsDisplay()
        case 2:
            responseStepper.value = Double(master[assessment].T2R)
            errorStepper.value = Double(master[assessment].T2E)
            responseLabel.text = String(master[assessment].T2R)
            errorLabel.text = String(master[assessment].T2E)
            totalLabel.text = String(master[assessment].T2T)
            
            canvasView.canDraw = true
            canvasView.lines = master[assessment].lines2[pageNumber - 1]
            canvasView.tempLines = master[assessment].tempLines2[pageNumber - 1]
            canvasView.setNeedsDisplay()
        case 3:
            responseStepper.value = Double(master[assessment].T3R)
            errorStepper.value = Double(master[assessment].T3E)
            responseLabel.text = String(master[assessment].T3R)
            errorLabel.text = String(master[assessment].T3E)
            totalLabel.text = String(master[assessment].T3T)
            
            canvasView.canDraw = true
            canvasView.lines = master[assessment].lines3[pageNumber - 1]
            canvasView.tempLines = master[assessment].tempLines3[pageNumber - 1]
            canvasView.setNeedsDisplay()
        default:
            print("Something failed here with assigning drawing view page values.")
        }
        
    }
    
    
    // MARK: - Tally
    
    @IBAction func responseStepperPressed(_ sender: UIStepper) {
        switch state {
        case currentForm[0]:
            sender.value = 0
        case currentForm[1]:
            if (ableToEdit) {
            master[assessment].T1R = Int(sender.value)
            master[assessment].T1T = Int(sender.value) - Int(errorStepper.value)
            responseLabel.text = Int(sender.value).description
            } else {
                sender.value = Double(master[assessment].T1R)
            }
        case currentForm[2]:
            if (ableToEdit) {
            master[assessment].T2R = Int(sender.value)
            master[assessment].T2T = Int(sender.value) - Int(errorStepper.value)
            responseLabel.text = Int(sender.value).description
            } else {
                sender.value = Double(master[assessment].T2R)
            }
        case currentForm[3]:
            if (ableToEdit) {
            master[assessment].T3R = Int(sender.value)
            master[assessment].T3T = Int(sender.value) - Int(errorStepper.value)
            responseLabel.text = Int(sender.value).description
            } else {
                sender.value = Double(master[assessment].T3R)
            }
        default:
            print("Something went wrong with the UI Stepper switch statement")
        
    }
        totalLabel.text = String(Int(sender.value) - Int(errorStepper.value))
        master[assessment].sumR = master[assessment].T1R + master[assessment].T2R + master[assessment].T3R
        master[assessment].sumE = master[assessment].T1E + master[assessment].T2E + master[assessment].T3E
        master[assessment].sumT = master[assessment].T1T + master[assessment].T2T + master[assessment].T3T
    }
    
    @IBAction func errorStepperPressed(_ sender: UIStepper) {
        switch state {
        case currentForm[0]:
            sender.value = 0
        case currentForm[1]:
            if (ableToEdit) {
            master[assessment].T1E = Int(sender.value)
            master[assessment].T1T = Int(responseStepper.value) - Int(sender.value)
            errorLabel.text = Int(sender.value).description
            } else {
                sender.value = Double(master[assessment].T1E)
            }
        case currentForm[2]:
            if (ableToEdit) {
            master[assessment].T2E = Int(sender.value)
            master[assessment].T2T = Int(responseStepper.value) - Int(sender.value)
            errorLabel.text = Int(sender.value).description
            } else {
                sender.value = Double(master[assessment].T2E)
            }
        case currentForm[3]:
            if (ableToEdit) {
            master[assessment].T3E = Int(sender.value)
            master[assessment].T3T = Int(responseStepper.value) - Int(sender.value)
            errorLabel.text = Int(sender.value).description
            } else {
                sender.value = Double(master[assessment].T3E)
            }
        default:
            print("Something went wrong with the UI Stepper switch statement")
        }
        
        totalLabel.text = String(Int(responseStepper.value) - Int(sender.value))
        master[assessment].sumR = master[assessment].T1R + master[assessment].T2R + master[assessment].T3R
        master[assessment].sumE = master[assessment].T1E + master[assessment].T2E + master[assessment].T3E
        master[assessment].sumT = master[assessment].T1T + master[assessment].T2T + master[assessment].T3T
    }
    
    
    //MARK: - Timer
    
    //Timer Fire Function
    @objc func onTimerFire() {
        timeLeft -= 1
        if timeLeft > 2 {
            timerLabel.text = "\(timeLeft - 2)"
        }
        
        if (timeLeft <= 2) {
            //playSound(soundName: "Pling")
            timerLabel.text = "\(0)"
            canvasView.backgroundColor = .red
        }
        
        if (timeLeft <= 0) {
            canvasView.backgroundColor = .white
            timer?.invalidate()
            timer = nil
        }
    }
    
    //Timer Start Button
    @IBAction func startTimer(_ sender: UIButton) {
        if (ableToEdit) {
        if (!(timer?.isValid ?? false)) {
            if (!(timeLeft <= 0)) {
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFire), userInfo: nil, repeats: true)
            }
        }
        }
    }
    
    //Timer Reset Button
    @IBAction func resetTimer(_ sender: UIButton) {
        if (ableToEdit) {
            canvasView.backgroundColor = .white
            timeLeft = startingTime
            timerLabel.text = "\(timeLeft - 2)"
            timer?.invalidate()
        }
    }
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    //MARK: - Drawing
    
    var colors: [UIColor] = [UIColor.black, UIColor.blue, UIColor.red]
    
    @IBAction func onClickUndo(_ sender: UIButton) {
        if (ableToEdit) {
            canvasView.undoDraw()
        }
    }
    
    @IBAction func onClickRedo(_ sender: UIButton) {
        if (ableToEdit) {
            canvasView.redoDraw()
        }
    }
    
    @IBAction func onClickBrushSize(_ sender: UISlider) {
        if (ableToEdit) {
            canvasView.strokeWidth = CGFloat(sender.value)
        }
    }
    
    @IBAction func editButtonPressed(_ sender: CustomButton) {
        if (!ableToEdit) {
            ableToEdit = true
        } else {
            ableToEdit = false
        }
        if (editButton.borderColor != .red) {
            editButton.borderColor = .red
        } else {
            editButton.borderColor = .black
        }
        editButton.isHighlighted = !editButton.isHighlighted
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        if (normalMode) {
            performSegue(withIdentifier: "panelToHome", sender: self)
        } else {
            performSegue(withIdentifier: "panelToAssess", sender: self)
        }
    }
    
    
    @IBAction func backPagePressed(_ sender: CustomButton) {
        //back a page
        if ((state != currentForm[0]) && pageNumber <= 1) {
            pageNumber = 1
            switch state {
            case currentForm[1]:
                canvasView.lines = master[assessment].lines1[pageNumber - 1]
                canvasView.tempLines = master[assessment].tempLines1[pageNumber - 1]
                canvasView.setNeedsDisplay()
            case currentForm[2]:
                canvasView.lines = master[assessment].lines2[pageNumber - 1]
                canvasView.tempLines = master[assessment].tempLines2[pageNumber - 1]
                canvasView.setNeedsDisplay()
            case currentForm[3]:
                canvasView.lines = master[assessment].lines3[pageNumber - 1]
                canvasView.tempLines = master[assessment].tempLines3[pageNumber - 1]
                canvasView.setNeedsDisplay()
            default:
                print("Something went wrong with page selection")
            }
        } else if ((state != currentForm[0]) && pageNumber > 1) {
            pageNumber -= 1
            switch state {
            case currentForm[1]:
                canvasView.lines = master[assessment].lines1[pageNumber - 1]
                canvasView.tempLines = master[assessment].tempLines1[pageNumber - 1]
                canvasView.setNeedsDisplay()
            case currentForm[2]:
                canvasView.lines = master[assessment].lines2[pageNumber - 1]
                canvasView.tempLines = master[assessment].tempLines2[pageNumber - 1]
                canvasView.setNeedsDisplay()
            case currentForm[3]:
                canvasView.lines = master[assessment].lines3[pageNumber - 1]
                canvasView.tempLines = master[assessment].tempLines3[pageNumber - 1]
                canvasView.setNeedsDisplay()
            default:
                print("Something went wrong with page selection")
            }
        } else {
            pageNumber = 1
        }
        
        
        updatePageLabel()
        
    }
    
    @IBAction func nextPagePressed(_ sender: CustomButton) {
        //forward a page
        if ((state != currentForm[0]) && pageNumber >= 3) {
            pageNumber = 3
            switch state {
            case currentForm[1]:
                canvasView.lines = master[assessment].lines1[pageNumber - 1]
                canvasView.tempLines = master[assessment].tempLines1[pageNumber - 1]
                canvasView.setNeedsDisplay()
            case currentForm[2]:
                canvasView.lines = master[assessment].lines2[pageNumber - 1]
                canvasView.tempLines = master[assessment].tempLines2[pageNumber - 1]
                canvasView.setNeedsDisplay()
            case currentForm[3]:
                canvasView.lines = master[assessment].lines3[pageNumber - 1]
                canvasView.tempLines = master[assessment].tempLines3[pageNumber - 1]
                canvasView.setNeedsDisplay()
            default:
                print("Something went wrong with page selection")
            }
        } else if ((state != currentForm[0]) && pageNumber < 3) {
            pageNumber += 1
            switch state {
            case currentForm[1]:
                canvasView.lines = master[assessment].lines1[pageNumber - 1]
                canvasView.tempLines = master[assessment].tempLines1[pageNumber - 1]
                canvasView.setNeedsDisplay()
            case currentForm[2]:
                canvasView.lines = master[assessment].lines2[pageNumber - 1]
                canvasView.tempLines = master[assessment].tempLines2[pageNumber - 1]
                canvasView.setNeedsDisplay()
            case currentForm[3]:
                canvasView.lines = master[assessment].lines3[pageNumber - 1]
                canvasView.tempLines = master[assessment].tempLines3[pageNumber - 1]
                canvasView.setNeedsDisplay()
            default:
                print("Something went wrong with page selection")
            }
        } else {
            pageNumber = 1
        }
        updatePageLabel()
    }
    
    func updatePageLabel() {
        pageLabel.text = "Page: \(pageNumber)"
    }
    

}

extension DrawViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Color Cell", for: indexPath)
        if let view = cell.viewWithTag(10) {
            view.backgroundColor = colors[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (ableToEdit) {
        canvasView.strokeColor = colors[indexPath.row]
        if (canvasView.strokeColor == UIColor.black) {
            colorCollectionView.visibleCells[1].layer.borderWidth = 3
            colorCollectionView.visibleCells[1].layer.borderColor = .init(red: 0, green: 200, blue: 0, alpha: 200)
            
            colorCollectionView.visibleCells[0].layer.borderWidth = 0
            colorCollectionView.visibleCells[0].layer.borderColor = .none
            colorCollectionView.visibleCells[2].layer.borderWidth = 0
            colorCollectionView.visibleCells[2].layer.borderColor = .none
        } else if (canvasView.strokeColor == UIColor.blue) {
            colorCollectionView.visibleCells[0].layer.borderWidth = 3
            colorCollectionView.visibleCells[0].layer.borderColor = .init(red: 0, green: 200, blue: 0, alpha: 200)
            
            colorCollectionView.visibleCells[1].layer.borderWidth = 0
            colorCollectionView.visibleCells[1].layer.borderColor = .none
            colorCollectionView.visibleCells[2].layer.borderWidth = 0
            colorCollectionView.visibleCells[2].layer.borderColor = .none
        } else if (canvasView.strokeColor == UIColor.red) {
            colorCollectionView.visibleCells[2].layer.borderWidth = 3
            colorCollectionView.visibleCells[2].layer.borderColor = .init(red: 0, green: 200, blue: 0, alpha: 200)
            
            colorCollectionView.visibleCells[0].layer.borderWidth = 0
            colorCollectionView.visibleCells[0].layer.borderColor = .none
            colorCollectionView.visibleCells[1].layer.borderWidth = 0
            colorCollectionView.visibleCells[1].layer.borderColor = .none
        } else {
            print("Something went wrong with color selection")
        }
    }
    }
    
    
    
}


/*
// MARK: - Navigation
 
 

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/
