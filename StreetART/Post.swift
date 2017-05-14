//
//  Post.swift
//  StreetART
//
//  Created by George Allard on 12/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit


class Post: NSObject {
    
    
    var author: String!
    var likes: Int!
    var pathToImage: String!
    var userID: String!
    var postID: String!
    
    var peopleWhoLike: [String] = [String]()
    

}
