//
//  ResultViewController.swift
//  pelagia
//
//  Created by spiros on 15/01/2017.
//  Copyright © 2017 spiros. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var button: ZFRippleButton!

    @IBOutlet var result: UITextView!
    var resultString:String!
    var link:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        result.text = resultString

        // Do any additional setup after loading the view.
    }
    
    @IBAction func openWebPage(_ sender: UIButton) {
        let app = UIApplication.shared
        app.open(URL(string: link)!)
    }


}
