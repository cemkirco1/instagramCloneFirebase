//
//  ViewController.swift
//  instagramClone-Firebase
//
//  Created by cem on 9.12.2021.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
   
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func loginButtonClick(_ sender: Any)
    {
        
        if emailText.text != "" && passwordText.text != ""
        {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!)
            { autdata, error in
                if error != nil
                {
                    self.errorAlert(title: "Error", message: error?.localizedDescription ?? "Network Error")
                }
                else
                {
                    self.performSegue(withIdentifier: "loginto", sender: nil)
                }
            }
        }
        else
        {
            self.errorAlert(title: "Error", message: "Username and password blank")
        }
        
    }
    
    func errorAlert(title: String, message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(button)
    }

}

