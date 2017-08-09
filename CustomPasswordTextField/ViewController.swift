//
//  ViewController.swift
//  CustomPasswordTextField
//
//  Created by Aaqib Hussain on 6/8/17.
//  Copyright © 2017 Aaqib Hussain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customTextField: CustomPasswordTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
       print(customTextField.originalString)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

