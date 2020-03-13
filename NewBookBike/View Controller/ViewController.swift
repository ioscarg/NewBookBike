//
//  ViewController.swift
//  NewBookBike
//
//  Created by Oscar García García on 10/03/20.
//  Copyright © 2020 Oscar García García. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        imageLogo.image = UIImage (named: "Logo")
        
        // Do any additional setup after loading the view.
    }

        func setUpElements() {
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleFilledButton(loginButton)
            
    }
    
        
    @IBAction func loginTapped(_ sender: Any) {
       
        //Validar campos
             let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             //Ingresar con el usuario
             Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                 if error != nil {
//                     self.errorLabel.text = error!.localizedDescription
//                     self.errorLabel.alpha = 1
                 }else{
                     
                     let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
                     
                     self.view.window?.rootViewController = homeViewController
                     self.view.window?.makeKeyAndVisible()
                 }
             }
    }
}

