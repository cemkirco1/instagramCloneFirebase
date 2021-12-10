//
//  UploadController.swift
//  instagramClone-Firebase
//
//  Created by cem on 9.12.2021.
//

import UIKit
import Firebase

class UploadController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageGesture))
        imageView.addGestureRecognizer(gesture)
    
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
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    

    
    @IBAction func buttonClick(_ sender: Any)
    {
       
                   
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let mediaFolder = storageRef.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5)
        {
            
            let uuid = UUID().uuidString
            
            let imageRef = mediaFolder.child("\(uuid)")
            imageRef.putData(data, metadata: nil) { metadata, error in
                
                if error != nil{
                    self.errorAlert(title: "Error", message: error?.localizedDescription ?? "network error")
                }
                else
                {
                    imageRef.downloadURL
                    { (url, error) in
                        if error == nil
                        {
                            let imageUrl = url?.absoluteString
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreRef : DocumentReference? = nil
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "PostedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentText.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String : Any]
                            
                            firestoreRef = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion:
                            { (error) in
                                
                                if error != nil
                                {
                                    self.errorAlert(title: "error", message: error?.localizedDescription ?? "Network Error")
                                    
                                }
                                else
                                {
                                    self.imageView.image = UIImage(named: "select1.svg")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                        }
                    }
                }
                
            }
            
        }
        
    }
    
    
    func errorAlert(title: String, message : String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(button)
    }
}
