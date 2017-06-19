//
//  LoginViewController.swift
//  NawwarCo
//
//  Created by ardMac on 08/06/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!{
        didSet{
            emailTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet{
            passwordTextField.delegate = self
        }
    }
    
    var uid : String?
    var ref : DatabaseReference!
    var currentUser = User.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        handleLogin()
    }

    func handleLogin(){
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        
        if email == "" || password == "" {
            warningPopUp(withTitle: "Input Error", withMessage: "Email or Password can't be empty")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.warningPopUp(withTitle: "Input Error", withMessage: "Email or Password is incorrect")
                return
            }
            self.goToMainVC()
            self.clearTextField()
        })
    }
    func clearTextField(){
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    func goToMainVC(){
        let initController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MainViewController")
        present(initController, animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
