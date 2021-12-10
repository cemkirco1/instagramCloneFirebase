//
//  ProfileController.swift
//  instagramClone-Firebase
//
//  Created by cem on 9.12.2021.
//

import UIKit
import Firebase

class ProfileController: UIViewController {
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var collecitonView: UICollectionView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func getProfileDataFirbase()
    {
        
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Profile").addSnapshotListener
        { (snapshot, error) in
            
            if error != nil
            {
                print("error")
            }
            else
            {
                if snapshot?.isEmpty != true && snapshot != nil
                {
                   // let docRef = fireStoreDatabase.collection("Profile").document(<#T##documentPath: String##String#>)
                }
            }
            
        }
        
        

       /* let db = Firestore.firestore()
         let docRef = db.collection("Profile").document()

         docRef.getDocument { (document, error) in
             if let document = document, document.exists {
                 let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                 print("Document data: \(dataDescription)")
             } else {
                 print("Document does not exist")
             }
         }
        */
        
    }

 
}
