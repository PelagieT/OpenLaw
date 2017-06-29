//
//  ResultViewController.swift
//  pelagia
//
//  Created by spiros on 15/01/2017.
//  Copyright © 2017 spiros. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var result: UITextView!
    var resultString:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        result.text = resultString
        // Do any additional setup after loading the view.
    }

}
