//
//  EditProfileViewController.swift
//  StreetART
//
//  Created by George Allard on 16/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage



class EditProfileViewController: UIViewController {
    
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var about: UITextField!
    
    var dataBaseRef: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()

         dataBaseRef = FIRDatabase.database().reference()
         storageRef = FIRStorage.storage().reference()
        
        loadProfileData()
    }
    
    func loadProfileData(){
        
        if let userID = FIRAuth.auth()?.currentUser?.uid {
            dataBaseRef.child("users").child(userID).observe(.value, with: { (snapshot) in
                
                let values = snapshot.value as? NSDictionary
                
                if let profilePicture = values?["urlToImage"] as? String{
                    
                    self.profilePicture.sd_setImage(with: URL(string: profilePicture))
                }
                
                self.fullName.text = values?["full name"] as? String
                
                self.about.text = values?[""] as? String
        
        
    }

        )}
    }
}
