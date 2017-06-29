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
        if((selectedRow1 == "ΙΚΑ" || selectedRow1 == "ΟΑΕΕ" ) && selectedRow2 == "Επίδομα Απολύτου Αναπηρίας"){
            question1.text = "ΛΗΨΗ ΣΥΝΤΑΞΗΣ"
            pickerData1 = ["Γήρατος","Αναπηρίας","Θανάτου"]
            selectedRowCurrent1 = pickerview1.selectedRow(inComponent: 0)
        }else if (selectedRow1 == "ΔΗΜΟΣΙΟ-ΓΛΚ"){
            question1.text = "ΜΕΡΕΣ ΑΣΦΑΛΙΣΗΣ"
            pickerData1 = ["1 Ημέρα",">=4500"]
            selectedRowCurrent1 = pickerview1.selectedRow(inComponent: 0)
        }else{
            question1.text = "ΜΕΡΕΣ ΑΣΦΑΛΙΣΗΣ"
            pickerData1 = ["1 Ημέρα",">= 350 (50Η Προηγούμενο Έτος)",">=750ΗΕ",">= 1000 Οποτεδήποτε" ,">= 1500 (600ΗΕ τελ. 5ετία)", ">=2250",">=4050",">=4500",">=6000"]
            selectedRowCurrent1 = pickerview1.selectedRow(inComponent: 0)
        }
        question2.text = "ΠΟΣΟΣΤΟ ΑΝΑΠΗΡΙΑΣ"
        pickerData2 = ["<=50%",">=50%",">=67%",">=80%"]
        selectedRowCurrent2 = pickerview2.selectedRow(inComponent: 0)

    }
    
    func nextView(){
        var vc = self.storyboard!.instantiateViewController(withIdentifier: "Result") as! ResultViewController
        var links:[String:String] = [:]

        links["ΙΚΑ"] = "http://wapps.islab.uom.gr:8084/OpenHellenicLegislation/CategoryBrowser?subject=15b"
        links["ΟΑΕΕ"] = "http://wapps.islab.uom.gr:8084/OpenHellenicLegislation/CategoryBrowser?subject=39"
        links["ΓΛΚ"] = "http://wapps.islab.uom.gr:8084/OpenHellenicLegislation/CategoryBrowser?subject=29"

        
        if((selectedRow1 == "ΙΚΑ" || selectedRow1 == "ΟΑΕΕ") && selectedRow2 != "Επίδομα Απολύτου Αναπηρίας" ){
            if (selectedRow2 == "Σύνταξη Αναπηρίας Κοινή νόσος") && (selectedRowCurrent2 >= 1) && (selectedRowCurrent1 >= 4 ){
                if selectedRow1 == "ΟΑΕΕ" && selectedRowCurrent2 < 2{
                    vc.resultString = "ΠΑΡΟΧΗ OXI"
                } else{
                  vc.resultString = "ΠΑΡΟΧΗ ΝΑΙ"
                }
            } else if (selectedRow2 == "Σύνταξη Αναπηρίας Εργ.Ατύχημα") && selectedRowCurrent1 >= 0 && selectedRowCurrent2 >= 1{
                if selectedRow1 == "ΟΑΕΕ" && selectedRowCurrent2 < 2{
                    vc.resultString = "ΠΑΡΟΧΗ OXI"
                } else{
                    vc.resultString = "ΠΑΡΟΧΗ ΝΑΙ"
                }
            } else if (selectedRow2 == "Σύνταξη Αναπηρίας Ατύχημα Εκ. Εργασίας") && selectedRowCurrent1 >= 2 && selectedRowCurrent2 >= 1 {
                if selectedRow1 == "ΟΑΕΕ" && selectedRowCurrent2 < 2{
                    vc.resultString = "ΠΑΡΟΧΗ OXI"
                } else{
                    vc.resultString = "ΠΑΡΟΧΗ ΝΑΙ"
                }
            } else if (selectedRow2 == "Επίδομα Απολύτου Αναπηρίας") && selectedRowCurrent2 >= 3 {
                   vc.resultString = "ΠΑΡΟΧΗ ΝΑΙ"
            } else if (selectedRow2 == "Εξωιδρυματικό Παραπληγ. Επίδομα") && selectedRowCurrent1 >= 1 && selectedRowCurrent2 >= 2 {
                vc.resultString = "ΠΑΡΟΧΗ ΝΑΙ"
            } else if (selectedRow2 == "Σύνταξη Γήρατος(Με ειδ. διατάξεις)") && selectedRowCurrent1 >= 6 && selectedRowCurrent2 >= 2 {
                vc.resultString = "ΠΑΡΟΧΗ ΝΑΙ"
            } else {
                vc.resultString = "ΠΑΡΟΧΗ OXI"
            }
            
        } else if((selectedRow1 == "ΙΚΑ" || selectedRow1 == "ΟΑΕΕ") && selectedRow2 == "Επίδομα Απολύτου Αναπηρίας"){
            if(selectedRowCurrent2 >= 3){
               vc.resultString = "ΠΑΡΟΧΗ ΝΑΙ"
            } else {
               vc.resultString = "ΠΑΡΟΧΗ OXI"
            }
        } else if selectedRow1 == "ΔΗΜΟΣΙΟ-ΓΛΚ" && selectedRow2 == "Οφειλόμενη στην Υπηρεσία"{
            if(selectedRowCurrent1 >= 0 && selectedRowCurrent2 >= 2){
               vc.resultString = "ΠΑΡΟΧΗ ΝΑΙ"
            } else {
               vc.resultString = "ΠΑΡΟΧΗ OXI"
            }
        } else if selectedRow1 == "ΔΗΜΟΣΙΟ-ΓΛΚ" && selectedRow2 == "Μη οφειλόμενη στην Υπηρεσία"{
            if(selectedRowCurrent1 >= 1 && selectedRowCurrent2 >= 2){
                vc.resultString = "ΠΑΡΟΧΗ ΝΑΙ"
            } else {
                vc.resultString = "ΠΑΡΟΧΗ OXI"
            }
        } else {
            vc.resultString = "ΠΑΡΟΧΗ OXI"
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
