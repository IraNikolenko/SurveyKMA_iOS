//
//  LoginViewController.swift
//  SurveyKMA_iOS
//
//  Created by admin on 11.06.17.
//  Copyright © 2017 IraNikolenko. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createNewAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        
        loginButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        passwordTextField.isSecureTextEntry = true
        createNewAccountButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func register(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "RegisterViewController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func handleRegister(){
        guard let email = emailTextField.text, let password = passwordTextField.text
            else{
                print("Form not valid")
                return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user:FIRUser?, error) in
            if error != nil {
                print (error ?? "")
                return
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "MainScreenViewController")
            self.navigationController?.pushViewController(controller, animated: true)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
