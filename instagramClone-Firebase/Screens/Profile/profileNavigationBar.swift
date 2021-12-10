//
//  profileNavigationBar.swift
//  instagramClone-Firebase
//
//  Created by cem on 11.12.2021.
//

import UIKit
import Firebase


class profileNavigationBar: UINavigationBar {

   

    @IBAction func exitButton(_ sender: Any)
    {
       
        do
        {
            try Auth.auth().signOut()
            
        }
        catch
        {
            print("Error")
        }
        
    }
}
