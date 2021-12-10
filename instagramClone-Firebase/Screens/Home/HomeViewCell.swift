//
//  HomeViewCell.swift
//  instagramClone-Firebase
//
//  Created by cem on 10.12.2021.
//

import UIKit
import Firebase

class HomeViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeButtonPainted: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var postId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonClick(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()
        likeButton.isHidden = true
        likeButtonPainted.isHidden = false
        
        if let likeCount = Int(likeLabel.text!){
            let likeStore = ["likes":likeCount + 1 ] as [String : Any]
            firestoreDatabase.collection("Posts").document(postId.text!).setData(likeStore, merge: true)
        }
    }
    
    @IBAction func likeButtonPaintedClick(_ sender: Any) {
        let firestoreDatabased = Firestore.firestore()
        
        likeButton.isHidden = false
        likeButtonPainted.isHidden = true
        
        if let likeCounts = Int(likeLabel.text!){
            let likeStores = ["likes" : likeCounts - 1 ] as [String : Any]
            firestoreDatabased.collection("Posts").document(postId.text!).setData(likeStores, merge: true)
        }
    }
    
    
    
    
    

}
