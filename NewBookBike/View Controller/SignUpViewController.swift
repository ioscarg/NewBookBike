//
//  SignUpViewController.swift
//  NewBookBike
//
//  Created by Oscar García García on 10/03/20.
//  Copyright © 2020 Oscar García García. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var contrasenaTextField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        // Do any additional setup after loading the view.
    }
    func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(contrasenaTextField)
        Utilities.styleFilledButton(SignUpButton)
    }
    
    @IBAction func signUpTap(_ sender: Any) {
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = contrasenaTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().createUser(withEmail: email, password: password){
            (result, err) in
            if err != nil {
                self.showError("Error en crear el usuario")
            }else {
                let db = Firestore.firestore()
                db.collection("usuarios").addDocument(data: ["correo":email, "contraseña":password, "uid":result!.user.uid]){
                    (error) in
                    if error != nil {
                        self.showError("No se pudo crear el usuario en la base de datos")
                    }
                }
                self.transitionToHome()
            }
        }
    }
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
}
