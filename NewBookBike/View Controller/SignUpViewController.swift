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
//import FirebaseFirestore

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
    
    func validateFields() -> String?
       {
           //Verificar que los campos no esten vacios
           
           if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               contrasenaTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
           {
               return "Por favor ingresa informacion"
           }
           
           //Verificar que la contraseña es segura
           
           let cleanedPassword = contrasenaTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
           
           if Utilities.isPasswordValid(cleanedPassword) == false {
               
               return "Verificar que el tamaño sea de 8 y tenga caracteres especiales"
           }
           
           return nil
       }
    
    @IBAction func signUpTap(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil{
            //Ocurrio un error y se tiene que mostrar el mensaje
            showError(error!)
            
        }else{
            
            //Crear una version limpia de los datos
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let password = contrasenaTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // verificar errores
                if err != nil {
                    
                    //Ocurrio un error al crear el usuario
                    self.showError("Error creando al usuario")
                    
                    
                }else{
                    //El usuario se creo bien
                    
                    let db = Firestore.firestore()
                    
                    
                    db.collection("usuarios").addDocument(data: ["email":email,"password": password, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                            self.showError("No se pudo crear el usuario en la base de datos")
                        }
                    }
                    
                    //Transicion a menu principal
                    self.transitionToHome()
                }
                
            }
            //Crear al usuario
        }
        
        //Crear al usuario
        
        //Navegacion
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
