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



class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
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
    
    
    @IBAction func saveProfile(_ sender: Any) {
        
        updateUsersProfile()
        
        
    }
    
    func updateUsersProfile(){
        
        
        
    }
    
    @IBAction func getPhoto(_ sender: Any) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
        
        
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        profilePicture.image = chosenImage
        dismiss(animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
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
