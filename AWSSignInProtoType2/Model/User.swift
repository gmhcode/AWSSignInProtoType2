//
//  User.swift
//  AWSSignInProtoType2
//
//  Created by Greg Hughes on 3/28/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation

class User : Codable {
    
    
    let email : String
    let uuid : String
    let username : String
    let password : String
    
    init(email: String, uuid: String, username: String, password: String) {
        self.email = email
        self.uuid = uuid
        self.username = username
        self.password = password
    }
}
