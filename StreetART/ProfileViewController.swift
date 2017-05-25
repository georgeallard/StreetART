//
//  ProfileViewController.swift
//  StreetART
//
//  Created by George Allard on 16/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit
import Firebase


class ProfileViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var about: UITextField!
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    var customImageFlowLayout: CustomImageFlowLayout!
    var dataBaseRef: FIRDatabaseReference!
    var storageRef: FIRStorage!
    var images = [UserImage]()
    var dbRef: FIRDatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = FIRDatabase.database().reference().child("images")
        loadDB()
        customImageFlowLayout = CustomImageFlowLayout()
        imageCollection.collectionViewLayout = customImageFlowLayout
        imageCollection.backgroundColor = .white
        
       
       dataBaseRef = FIRDatabase.database().reference()
        
        if let userID = FIRAuth.auth()?.currentUser?.uid {
            
            dataBaseRef.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let dictionary = snapshot.value as? NSDictionary
                
                let fullname = dictionary?["full name"] as? String ?? "Full Name"
                
                if let profilePictureURL = dictionary?["urlToImage"]as? String{
                    
                    let url = URL(string: profilePictureURL)
                    
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        
                        if error != nil{
                            print(error!)
                            return
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.profilePicture.image = UIImage(data: data!)
                            
                        }
                    }) . resume()
                }
                
                self.name.text = fullname
                
            }) { (error) in
                print(error.localizedDescription)
                return
            
            }
        }
    
    }
    
    func loadDB() {
        dbRef.observe(FIRDataEventType.value, { (snapshot) in
            var newImages = [UserImage]()
            
            for userImageSnapshot in snapshot.children {
                
                let userImageObject = userImage(snapshot: userImageSnapshot as! FIRDataSnapshot)
                newImages.append(userImageObject)
            }

        self.images = newImages
        self.imageCollection.reloadData()
        
    })
    
}



    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! imageCollectionViewCell
        
        let image = images[indexPath.row]

        cell.imageView.image = image;
        return cell
        
        
    }


}

