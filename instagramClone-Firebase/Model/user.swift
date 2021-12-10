//
//  user.swift
//  instagramClone-Firebase
//
//  Created by cem on 10.12.2021.
//

import Foundation


struct User {
    
    let uid : String
    let userName: String
    let profileImageUrl : String?
    
    init(uid: String, dictionary : [String : Any]) {
        
        self.uid = uid
        self.userName = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ??  nil
        
    }
    
    
    
}
