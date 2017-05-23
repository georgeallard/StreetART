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
    
    
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func getPhoto(_ sender: Any) {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    
        
    }


    func updateUsersProfile(){
        
        if let userID = FIRAuth.auth()?.currentUser?.uid {
            
            let storageItem = storageRef.child("users").child(userID)
            guard let image = profilePicture.image else { return }
            
            if let newImage = UIImagePNGRepresentation(image){
                storageItem.put(newImage, metadata: nil, completion: { metadata, error in
                    if error != nil{
                        print(error!)
                        return
                    }
                    
                    storageItem.downloadURL(completion: { url, error in
                        if error != nil{
                            print(error!)
                            return
                        }
                        
                        if let profilePicture = url?.absoluteString{
                            
                            guard let newFullName = self.fullName.text else {return}
                            guard let about = self.about.text else {return}
                            
                            let newValuesForProfile = [
                                "urlToImage": profilePicture,
                                "fullname": newFullName,
                                "about": about
                            ]
                            
                            self.dataBaseRef.child("users").child(userID).updateChildValues(newValuesForProfile, withCompletionBlock: { error, ref in
                                
                                if error != nil{
                                    print(error!)
                                    return
                                }
                                
                                print ("Profile Updated")
                                
                            })
                            
                            
                        }
                    })
                })
            }

        }
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
                
                self.about.text = values?["about"] as? String
        
        
            })

        }
    }
}
    

    

