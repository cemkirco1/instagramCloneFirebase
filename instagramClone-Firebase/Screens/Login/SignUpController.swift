//
//  SignUpController.swift
//  instagramClone-Firebase
//
//  Created by cem on 9.12.2021.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    @IBOutlet weak var ppImage: UIImageView!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func errorAlert(title : String, message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
    }
    

    @IBAction func siginUpClick(_ sender: Any)
    {
        if emailText.text != "" && passwordText.text != "" && nameText.text != ""
        {
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!)
            { authdata, error in
                if error != nil
                {
                    self.errorAlert(title: "Error", message: error?.localizedDescription ?? "Network Alert")
                }
                else
                {
                    self.performSegue(withIdentifier: "signupto", sender: nil)
                }
                
            }
            
            
        }
        else
        {
            self.errorAlert(title: "Error", message: "Username/Password blank")
        }
        
    }
    
    

}
