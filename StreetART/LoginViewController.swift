//
//  LoginViewController.swift
//  StreetART
//
//  Created by George Allard on 08/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit
import Firebase
import TextFieldEffects

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
     
        

    }
    
   // func dismissKeyboard(_ emailField: UITextField) -> Bool {
        
     //   emailField.resignFirstResponder()
       // return true
        
    //}

    
    @IBAction func LoginPressed(_ sender: Any) {
       
        
        guard emailField.text != "", passwordField.text != "" else {return}
        
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            
            if user != nil {
                
                self.performSegue(withIdentifier: "TabBar", sender: nil)
                
        //        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserVC")
                
              //  self.present(vc, animated: true, completion: nil)
            }
        })
        
        
    }
    
    
}
