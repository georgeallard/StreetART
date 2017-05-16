//
//  ProfileViewController.swift
//  StreetART
//
//  Created by George Allard on 16/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit
import Firebase


class ProfileViewController: UIViewController {
    

    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var about: UITextField!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    
    var dataBaseRef: FIRDatabaseReference!
    
    var storageRef: FIRStorage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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





}
    
