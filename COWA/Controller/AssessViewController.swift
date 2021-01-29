//
//  AssessTableViewController.swift
//  COWA
//
//  Created by Lucas Deane on 11/2/20.
//

import UIKit

class AssessViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIDocumentInteractionControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var selectAllButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var exportButton: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var allSelected = false
    var canSelect = true
    
    var cells: [AssessCell] = []
    
    var selectedIndex = 0
    
    var isSearching = false;
    var filteredAss = [Assessment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isEditing = false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        searchBar.delegate = self
        searchBar.keyboardType = UIKeyboardType.decimalPad
        searchBar.returnKeyType = UIReturnKeyType.done
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredAss.count
        } else {
            return master.count
        }
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ass: Assessment
        if (!isSearching) {
            ass = master[indexPath.row]
        } else {
            ass = filteredAss[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AssessCell
        if (!cells.contains(cell)) {
            cells.append(cell)
        }
            
        cell.AIDLabel?.text = "AID: \(ass.AID)"
        cell.SIDLabel?.text = "SID: \(ass.SID)"
        cell.DateLabel?.text = "\(ass.visitDate)"
        cell.VisitNumLabel?.text = "Visit #: \(String(ass.visitNum))"
        if (ass.checked) {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        }
        cell.ExportedLabel.text = "Export Amount: \(ass.exported.description)"
        
        /*for i in 0...(master.count - 1) {
            if (cell.AIDLabel.text == "AID: \(master[i].AID)" && master[i].checked) {
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
            } else if (cell.AIDLabel.text == "AID: \(master[i].AID)" && !master[i].checked) {
                cell.accessoryType = UITableViewCell.AccessoryType.none
            } else {
                print("What")
            }
        }*/

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 90
        }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let exportAlert = UIAlertController(title: "Deletion", message: "Are you sure you want to delete this row?", preferredStyle: UIAlertController.Style.alert)

                exportAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [self] (action: UIAlertAction!) in
                
                    for i in 0...(master.count - 1) {
                        let cell = tableView.cellForRow(at: indexPath) as! AssessCell?
                        if cell?.AIDLabel.text == "AID: \(master[i].AID)" {
                            master.remove(at: i)
                            break
                        } else {
                            print("Something went wrong with cell deletion")
                        }
                    }
                    if (isSearching) {
                        filteredAss.remove(at: indexPath.item)
                    }
                    tableView.deleteRows(at: [indexPath], with: .fade)
                
                }))

                exportAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                      print("Chose cancel with export")
                }))

                present(exportAlert, animated: true, completion: nil)
                updateTable()
                tableView.reloadData()
        }
    }
    
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (canSelect) {
            for ass in master {
                let cell = tableView.cellForRow(at: indexPath) as! AssessCell?
                if cell?.AIDLabel.text == "AID: \(ass.AID)" {
                    selectedAssessment = ass
                    performSegue(withIdentifier: "detailSegue", sender: self)
                } else {
                    print("Something went wrong with cell selection")
                }
            }
        } else if (!canSelect && selectButton.isSelected) {
            for i in 0...(master.count - 1) {
                let cell = tableView.cellForRow(at: indexPath) as! AssessCell?
                if cell?.AIDLabel.text == "AID: \(master[i].AID)" {
                    master[i].checked = !master[i].checked
                    updateTable()
                    tableView.reloadData()
                } else {
                    print("Something went wrong with cell checking")
                }
            }
        } else {
            print("Nothing state in cell selection")
        }
    }
    
    
    
    //MARK: - Selection/Edit Handling
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        //tableView.allowsSelection = false
        selectButton.isSelected = false
        tableView.isEditing = !tableView.isEditing
        sender.isSelected = tableView.isEditing
    }
    
    @IBAction func selectAllButtonPressed(_ sender: UIButton) {
        if (!allSelected) {
            for i in 0...(master.count - 1) {
                master[i].checked = true
            }
            updateTable()
            allSelected = true
        } else {
            for i in 0...(master.count - 1) {
                master[i].checked = false
            }
            updateTable()
            allSelected = false
        }
        tableView.reloadData()
    }
    
    @IBAction func selectButtonPressed(_ sender: UIButton) {
        tableView.isEditing = false
        editButton.isSelected = false
        sender.isSelected = !sender.isSelected
        canSelect = !sender.isSelected
    }
    
    @IBAction func exportButtonPressed(_ sender: UIButton) {
        var count = 0
        for cell in cells {
            if cell.accessoryType == UITableViewCell.AccessoryType.checkmark {
                count += 1
            }
        }
        
        if (count == 0) {
            let alert = UIAlertController(title: "Export Error", message: "You must select at least one item to be exported", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            self.present(alert, animated: true, completion: nil)
        } else {
                let exportAlert = UIAlertController(title: "Export", message: "Are you sure you want to export this data?", preferredStyle: UIAlertController.Style.alert)

                exportAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [self] (action: UIAlertAction!) in
                        //EXPORT CODE
                    
                    let tmpDir = FileManager.default.temporaryDirectory
                    var fileURL : URL
                    let fileName = "test.csv"
                    fileURL = tmpDir.appendingPathComponent(fileName)
                    var str = "sid, assess_id, redcap_event_name, redcap_repeat_instrument, redcap_repeat_instance, redcap_data_access_group, redcap_survey_identifier, cowa_t1r, cowa_t1e, cowa_t1c, cowa_t2r, cowa_t2e, cowa_t2c, cowa_t3r, cowa_t3e, cowa_t3c, cowa_sumr, cowa_sume, cowa_sumc, cowa_form"
                    
                    for cell in cells {
                        if cell.accessoryType == UITableViewCell.AccessoryType.checkmark {
                            for ass in master {
                                if cell.AIDLabel.text == "AID: \(ass.AID)" {
                                    print(ass.formNum)
                                    str.append("\n\(ass.SID), \(ass.AID), visit_data_arm_1, , \(ass.visitNum), uihc, , \(ass.T1R), \(ass.T1E), \(ass.T1T), \(ass.T2R), \(ass.T2E), \(ass.T2T), \(ass.T3R), \(ass.T3E), \(ass.T3T), \(ass.sumR), \(ass.sumE), \(ass.sumT), \(ass.formNum)")
                                }
                            }
                        }
                    }
                    
                    do {
                        try str.write(to: fileURL, atomically: false, encoding: .utf8)
                    } catch {
                        print(error)
                    }
                    
                    let activityController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
                    
                    if let popoverController = activityController.popoverPresentationController {
                        popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                            popoverController.sourceView = self.view
                            popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                        }
                    
                    
                    activityController.completionWithItemsHandler = { (nil, completed, _, error)
                        in
                        if completed {
                            for ass in master {
                                if ass.checked == true {
                                    ass.exported += 1
                                }
                            }
                            tableView.reloadData()
                        } else {
                            print("uploading canceled")
                        }
                    }

                        self.present(activityController, animated: true, completion: nil)
                }))

                exportAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                      print("Chose cancel with export")
                }))

                present(exportAlert, animated: true, completion: nil)
                updateTable()
                tableView.reloadData()
        }
        
    }
     
    //MARK: - Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if (searchBar.text == nil) {
            view.endEditing(true);
        }
        
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            
            tableView.reloadData()
        } else {
            print("Searching........")
            isSearching = true
            
            filteredAss = master.filter({ass -> Bool in
                guard let text = searchBar.text else {return false}
                return ass.AID.contains(text) || ass.SID.contains(text) ||
                    ass.visitDate.contains(text)
            })
            
            tableView.reloadData()
        }
    }
    
    //keyboard enter action
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true);
    }
    
    func updateTable() {
        if (isSearching) {
            for i in 0...(master.count - 1) {
                for j in 0...(filteredAss.count - 1) {
                    if (master[i].AID == filteredAss[j].AID) {
                        filteredAss[j].checked = master[i].checked
                        filteredAss[j].exported = master[i].exported
                        break
                    }
                }
            }
            tableView.reloadData()
        }
    }
     
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
