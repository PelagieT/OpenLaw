//
//  PageViewController.swift
//  pelagia
//
//  Created by spiros on 06/01/2017.
//  Copyright © 2017 spiros. All rights reserved.
//

import UIKit

class PageViewController2: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    @IBOutlet var pickerview1: UIPickerView!
    @IBOutlet var pickerview2: UIPickerView!
    var pickerData1: [String] = [String]()
    var pickerData2: [String] = [String]()
    var selectedRow1:String!
    var selectedRow2:String!
    var selectedRowCurrent1:Int!
    var selectedRowCurrent2:Int!
    
    
    @IBOutlet var question1: UITextView!
    @IBOutlet var question2: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pickerview1.delegate = self
        pickerview2.delegate = self
        pickerview1.dataSource = self
        pickerview2.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Επόμενο", style: .plain, target: self, action: #selector(nextView))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(selectedRow2)
        print(selectedRow1)
        if((selectedRow1 == "ΙΚΑ" || selectedRow1 == "ΟΑΕΕ" ) && selectedRow2 == "Απόλυτη Αναπηρία"){
            question1.text = "ΛΗΨΗ ΣΥΝΤΑΞΗΣ"
            pickerData1 = ["Γήρατος","Αναπηρίας","Θανάτου"]
            selectedRowCurrent1 = pickerview1.selectedRow(inComponent: 0)
        }else if (selectedRow1 == "ΔΗΜΟΣΙΟ-ΓΛΚ"){
            question1.text = "ΜΕΡΕΣ ΑΣΦΑΛΙΣΗΣ"
            pickerData1 = ["1 Ημέρα",">=4500"]
            selectedRowCurrent1 = pickerview1.selectedRow(inComponent: 0)
        }else if ((selectedRow1 == "ΙΚΑ" || selectedRow1 == "ΟΑΕΕ" ) && selectedRow2 == "Εργατικό Ατύχημα"){
            question1.text = "ΜΕΡΕΣ ΑΣΦΑΛΙΣΗΣ"
            pickerData1 = ["1 ημέρα"]
            selectedRowCurrent1 = pickerview1.selectedRow(inComponent: 0)
        }else if ((selectedRow1 == "ΙΚΑ") && selectedRow2 == "Ατύχημα Εκτός Εργασίας"){
            question1.text = "ΜΕΡΕΣ ΑΣΦΑΛΙΣΗΣ"
            pickerData1 = ["0-749","750-2249 (300ΗΕ τελ. 5ετία)","2250-4500",">4500"]
            selectedRowCurrent1 = pickerview1.selectedRow(inComponent: 0)
        }else if (selectedRow1 == "ΟΑΕΕ" && selectedRow2 == "Ατύχημα Εκτός Εργασίας"){
            question1.text = "ΜΕΡΕΣ ΑΣΦΑΛΙΣΗΣ"
            pickerData1 = ["0-749","750-2249 (600 τελ. 5ετία)",">2250"]
            selectedRowCurrent1 = pickerview1.selectedRow(inComponent: 0)
        }else if ((selectedRow1 == "ΙΚΑ" || selectedRow1 == "ΟΑΕΕ" ) && selectedRow2 == "Παραπληγία"){
            question1.text = "ΜΕΡΕΣ ΑΣΦΑΛΙΣΗΣ"
            pickerData1 = ["0-349","350-999 (50ΗΕ προηγ. έτος)",">1000"]
            selectedRowCurrent1 = pickerview1.selectedRow(inComponent: 0)
        }else if ((selectedRow1 == "ΙΚΑ" || selectedRow1 == "ΟΑΕΕ" ) && selectedRow2 == "Γήρας (Ειδ. διατάξεις)"){
            question1.text = "ΜΕΡΕΣ ΑΣΦΑΛΙΣΗΣ"
            pickerData1 = ["0-4049",">4050"]
            selectedRowCurrent1 = pickerview1.selectedRow(inComponent: 0)
        }else{
            question1.text = "ΜΕΡΕΣ ΑΣΦΑΛΙΣΗΣ"
            pickerData1 = ["0-1499","1500-4499 (600 τελ. 5ετία)",">4500"]
            selectedRowCurrent1 = pickerview1.selectedRow(inComponent: 0)
        }
        question2.text = "ΠΟΣΟΣΤΟ ΑΝΑΠΗΡΙΑΣ"
        pickerData2 = ["0-49.99%","50-66.99%","67-79.99%","80%-100%"]
        selectedRowCurrent2 = pickerview2.selectedRow(inComponent: 0)

    }
    
    @objc func nextView(){
        var vc = self.storyboard!.instantiateViewController(withIdentifier: "Result") as! ResultViewController
        var links:[String:String] = [:]

        links["ΙΚΑ"] = "http://wapps.islab.uom.gr:8084/OpenHellenicLegislation/CategoryBrowser?subject=15b"
        links["ΟΑΕΕ"] = "http://wapps.islab.uom.gr:8084/OpenHellenicLegislation/CategoryBrowser?subject=39"
        links["ΓΛΚ"] = "http://wapps.islab.uom.gr:8084/OpenHellenicLegislation/CategoryBrowser?subject=29"

        
        if((selectedRow1 == "ΙΚΑ" || selectedRow1 == "ΟΑΕΕ") && selectedRow2 != "Απόλυτη Αναπηρία" ){
            if (selectedRow2 == "Κοινή νόσος") && selectedRow1 == "ΙΚΑ" && (selectedRowCurrent2 >= 1) && (selectedRowCurrent1 >= 1 ){
                vc.resultString = "ΣΥΝΤΑΞΗ ΑΝΑΠΗΡΙΑΣ ΚΟΙΝΗ ΝΟΣΟΣ"
            }else if (selectedRow2 == "Κοινή νόσος") && selectedRow1 == "ΟΑΕΕ" && (selectedRowCurrent2 >= 2) && (selectedRowCurrent1 >= 1 ){
                vc.resultString = "ΣΥΝΤΑΞΗ ΑΝΑΠΗΡΙΑΣ ΚΟΙΝΗ ΝΟΣΟΣ"
            }else if (selectedRow2 == "Εργατικό Ατύχημα") && selectedRowCurrent1 >= 0 && selectedRowCurrent2 >= 1{
                if selectedRow1 == "ΟΑΕΕ" && selectedRowCurrent2 < 2{
                    vc.resultString = "ΑΠΟΡΡΙΨΗ ΑΣΦΑΛΙΣΤΙΚΗΣ ΠΑΡΟΧΗΣ"
                } else{
                    vc.resultString = "ΣΥΝΤΑΞΗ ΑΝΑΠΗΡΙΑΣ ΕΡΓ. ΑΤΥΧΗΜΑ"
                }
            } else if (selectedRow2 == "Ατύχημα Εκτός Εργασίας") && selectedRow1 == "ΙΚΑ" && selectedRowCurrent1 >= 1 && selectedRowCurrent2 >= 1 {
                   vc.resultString = "ΣΥΝΤΑΞΗ ΑΝΑΠΗΡΙΑΣ ΑΤΥΧΗΜΑ ΕΚΤΟΣ ΕΡΓΑΣΙΑΣ"
            } else if (selectedRow2 == "Ατύχημα Εκτός Εργασίας") && selectedRow1 == "ΟΑΕΕ" && selectedRowCurrent1 >= 1 && selectedRowCurrent2 >= 2 {
                vc.resultString = "ΣΥΝΤΑΞΗ ΑΝΑΠΗΡΙΑΣ ΑΤΥΧΗΜΑ ΕΚΤΟΣ ΕΡΓΑΣΙΑΣ"
            } else if (selectedRow2 == "Απόλυτη Αναπηρία") && selectedRowCurrent2 >= 3 {
                   vc.resultString = "ΕΠΙΔΟΜΑ ΑΠΟΛΥΤΟΥ ΑΝΑΠΗΡΙΑΣ"
            } else if (selectedRow2 == "Παραπληγία") && selectedRowCurrent1 >= 1 && selectedRowCurrent2 >= 2 {
                vc.resultString = "ΠΑΡΑΠΛΗΓΙΚΟ ΕΠΙΔΟΜΑ"
            } else if (selectedRow2 == "Γήρας (Ειδ. διατάξεις)") && selectedRowCurrent1 >= 1 && selectedRowCurrent2 >= 2 {
                vc.resultString = "ΣΥΝΤΑΞΗ ΓΗΡΑΤΟΣ (ΕΙΔ. ΔΙΑΤΑΞΕΙΣ)"
            } else {
                vc.resultString = "ΑΠΟΡΡΙΨΗ ΑΣΦΑΛΙΣΤΙΚΗΣ ΠΑΡΟΧΗΣ"
            }
            
        } else if((selectedRow1 == "ΙΚΑ" || selectedRow1 == "ΟΑΕΕ") && selectedRow2 == "Απόλυτη Αναπηρία"){
            if(selectedRowCurrent2 >= 3){
               vc.resultString = "ΕΠΙΔΟΜΑ ΑΠΟΛΥΤΟΥ ΑΝΑΠΗΡΙΑΣ"
            } else {
               vc.resultString = "ΑΠΟΡΡΙΨΗ ΑΣΦΑΛΙΣΤΙΚΗΣ ΠΑΡΟΧΗΣ"
            }
        } else if selectedRow1 == "ΔΗΜΟΣΙΟ-ΓΛΚ" && selectedRow2 == "Οφειλόμενη στην Υπηρεσία"{
            if(selectedRowCurrent1 >= 0 && selectedRowCurrent2 >= 2){
               vc.resultString = "ΣΥΝΤΑΞΗ ΑΝΙΚΑΝΟΤΗΤΑΣ ΟΦΕΙΛΟΜΕΝΗ ΣΤΗΝ ΥΠΗΡΕΣΙΑ"
            } else {
               vc.resultString = "ΑΠΟΡΡΙΨΗ ΑΣΦΑΛΙΣΤΙΚΗΣ ΠΑΡΟΧΗΣ"
            }
        } else if selectedRow1 == "ΔΗΜΟΣΙΟ-ΓΛΚ" && selectedRow2 == "Μη οφειλόμενη στην Υπηρεσία"{
            if(selectedRowCurrent1 >= 1 && selectedRowCurrent2 >= 2){
                vc.resultString = "ΣΥΝΤΑΞΗ ΑΝΙΚΑΝΟΤΗΤΑΣ ΜΗ ΟΦΕΙΛΟΜΕΝΗ ΣΤΗΝ ΥΠΗΡΕΣΙΑ"
            } else {
                vc.resultString = "ΑΠΟΡΡΙΨΗ ΑΣΦΑΛΙΣΤΙΚΗΣ ΠΑΡΟΧΗΣ"
            }
        } else {
            vc.resultString = "ΑΠΟΡΡΙΨΗ ΑΣΦΑΛΙΣΤΙΚΗΣ ΠΑΡΟΧΗΣ"
        }
        
        if(selectedRow1 == "ΙΚΑ"){
            vc.link = links["ΙΚΑ"]!
        } else if (selectedRow1 == "ΟΑΕΕ"){
            vc.link = links["ΟΑΕΕ"]!
        } else if (selectedRow1 == "ΔΗΜΟΣΙΟ-ΓΛΚ"){
            vc.link = links["ΓΛΚ"]!
        }
        
    
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
            selectedRowCurrent1 = row
        } else{
            selectedRowCurrent2 = row
        }

    }
    
}
