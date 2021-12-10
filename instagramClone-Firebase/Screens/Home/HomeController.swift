//
//  HomeController.swift
//  instagramClone-Firebase
//
//  Created by cem on 9.12.2021.
//

import UIKit
import Firebase
import SDWebImage

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var emailArray = [String]()
    var commentArray = [String]()
    var postImageArray = [String]()
    var likeArray = [Int]()
    var documentIdArray = [String]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getFromData()
        
    }
    
    func getFromData()
    {
        
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener
        { (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription)
            }
            else
            {
                if snapshot?.isEmpty != true && snapshot != nil{
                    self.postImageArray.removeAll(keepingCapacity: false)
                    self.commentArray.removeAll(keepingCapacity: false)
                    self.emailArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)
                        
                        if let postComment = document.get("postComment") as? String{
                            self.commentArray.append(postComment)
                        }
                        if let postedBy = document.get("PostedBy") as? String{
                            self.emailArray.append(postedBy)
                        }
                        if let imageUrl = document.get("imageUrl") as? String{
                        self.postImageArray.append(imageUrl)
                        }
                        if let likes = document.get("likes") as? Int{
                        self.likeArray.append(likes)
                        }
                    }
                    self.tableView.reloadData()
                }
                
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeViewCell
                   cell.nameText.text = emailArray[indexPath.row]
                   cell.commentLabel.text = commentArray[indexPath.row]
                   cell.postId.text = documentIdArray[indexPath.row]
                   cell.likeLabel.text = String(likeArray[indexPath.row]) 
                   cell.postImage.sd_setImage(with: URL(string: self.postImageArray[indexPath.row]))
               
           
                   return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return emailArray.count
    }

}
