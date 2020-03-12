//
//  ViewController.swift
//  NewBookBike
//
//  Created by Oscar García García on 10/03/20.
//  Copyright © 2020 Oscar García García. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
        // Do any additional setup after loading the view.
    }

        func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleFilledButton(LoginButton)
    }
}

