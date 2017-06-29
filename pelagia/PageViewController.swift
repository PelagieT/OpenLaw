//
//  PageViewController.swift
//  pelagia
//
//  Created by spiros on 06/01/2017.
//  Copyright © 2017 spiros. All rights reserved.
//

import UIKit

class PageViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    @IBOutlet var pickerview1: UIPickerView!
    @IBOutlet var pickerview2: UIPickerView!
    @IBOutlet var question1: UITextView!
    @IBOutlet var question2: UITextView!
    
    var pickerData1: [String] = [String]()
    var pickerData2: [String] = [String]()
    var selectedRow1:String!
    var selectedRow2:String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerData1 = ["ΙΚΑ", "ΟΑΕΕ", "ΔΗΜΟΣΙΟ-ΓΛΚ"]
        pickerData2 = ["Σύνταξη Αναπηρίας Κοινή νόσος","Σύνταξη Αναπηρίας Εργ.Ατύχημα","Σύνταξη Αναπηρίας Ατύχημα Εκ. Εργασίας" ,"Επίδομα Απολύτου Αναπηρίας", "Εξωιδρυματικό Παραπληγ. Επίδομα","Σύνταξη Γήρατος(Με ειδ. διατάξεις)"]
        pickerview1.delegate = self
        pickerview2.delegate = self
        pickerview1.dataSource = self
        pickerview2.dataSource = self
        selectedRow1 = pickerData1[pickerview1.selectedRow(inComponent: 0)]
        selectedRow2 = pickerData2[pickerview2.selectedRow(inComponent: 0)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Επόμενο", style: .plain, target: self, action: #selector(nextView))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedRow1 = pickerData1[pickerview1.selectedRow(inComponent: 0)]
        selectedRow2 = pickerData2[pickerview2.selectedRow(inComponent: 0)]
    }
    
    func nextView(){
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "page2") as! PageViewController2
        vc.selectedRow1 = selectedRow1
        vc.selectedRow2 = selectedRow2
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func restart(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerview1{
           return pickerData1.count
        }else{
           return pickerData2.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerview1{
            return pickerData1[row]
        }else{
            return pickerData2[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel

        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "SanFranciscoText-Light", size: 30)
        label.adjustsFontSizeToFitWidth = true
        
        
        if pickerView == pickerview1{
            label.text = pickerData1[row]
        }else{
            label.text = pickerData2[row]
        }

        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerview1{
            selectedRow1 = pickerData1[row]
            if selectedRow1 == "ΔΗΜΟΣΙΟ-ΓΛΚ"{
                pickerData2 = ["Οφειλόμενη στην Υπηρεσία","Μη οφειλόμενη στην Υπηρεσία"]
                pickerview2.reloadAllComponents()
                selectedRow2 = pickerData2[pickerview2.selectedRow(inComponent: 0)]
            } else {
                pickerData2 = ["Σύνταξη Αναπηρίας Κοινή νόσος","Σύνταξη Αναπηρίας Εργ.Ατύχημα","Σύνταξη Αναπηρίας Ατύχημα Εκ. Εργασίας" ,"Επίδομα Απολύτου Αναπηρίας", "Εξωιδρυματικό Παραπληγ. Επίδομα","Σύνταξη Γήρατος(Με ειδ. διατάξεις)"]
                pickerview2.reloadAllComponents()
                selectedRow2 = pickerData2[pickerview2.selectedRow(inComponent: 0)]
            }
        } else{
            selectedRow2 = pickerData2[row]
        }
    }
    
}
