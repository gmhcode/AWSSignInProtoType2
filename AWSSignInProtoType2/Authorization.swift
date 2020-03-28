//
//  Authorization.swift
//  AWSSignInProtoType2
//
//  Created by Greg Hughes on 3/28/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import Foundation
import AWSMobileClient

struct Authorization {
    
    static func initialize() {
        AWSMobileClient.default().initialize { (userState, error) in
            if let userState = userState {
                print("UserState: \(userState.rawValue)")
            } else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    
}
