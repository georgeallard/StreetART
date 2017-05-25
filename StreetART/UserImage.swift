//
//  UserImage.swift
//  StreetART
//
//  Created by George Allard on 25/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct UserImage {
    
    let key: String!
    let url: String!
    
    let itemRef: FIRDatabaseReference
    
    init(url:String, key:String) {
        
        self.key = key
        self.url = url
        self.itemRef = snapshot.ref
        
        let snapshotValue = snapshot.value as? NSDictionary
        
        if let imageUrl = snapshotValue?["url"] as? String {
            url = imageUrl
        }else{
            url = ""
        }
        
        
        
    }
}
