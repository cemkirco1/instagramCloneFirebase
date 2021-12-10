//
//  SignUpController.swift
//  instagramClone-Firebase
//
//  Created by cem on 9.12.2021.
//

import UIKit
import Firebase

class SignUpController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    var userStorage : StorageReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageGesture))
        profileImage.addGestureRecognizer(gesture)
    }
    
    @objc func imageGesture()
    {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        profileImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
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
                    
                    let storage = Storage.storage()
                    let storageReference = storage.reference()
                    
                    let profileFolder = storageReference.child("profile")
                    
                    if let data = self.profileImage.image?.jpegData(compressionQuality: 0.5)
                    {
                        
                        let uid = UUID().uuidString
                        let imageReferance = profileFolder.child("\(uid).jpg")
                        imageReferance.putData(data, metadata: nil)
                        { metadata, error in
                            if error != nil {
                                self.errorAlert(title: "Error", message: error?.localizedDescription ?? "error")
                            }
                            else
                            {
                                imageReferance.downloadURL
                                { url, error in
                                    if error == nil
                                    {
                                        let profileImageUrl = url?.absoluteString
                                        
                                        let firestoreDatabase = Firestore.firestore()
                                        var firestoreReference : DocumentReference? = nil
                                        
                                        let firestoreProfile = ["ProfileimageUrl" : profileImageUrl, "Name" : self.nameText.text!, "PostedBy" : self.emailText.text] as [String : Any]
                                        firestoreReference = firestoreDatabase.collection("Profile").addDocument(data: firestoreProfile)
                                        
                                    }
                                }
                            }
                        }
                    }
                    
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
