//
//  ViewController.swift
//  AWSSignInProtoType2
//
//  Created by Greg Hughes on 3/28/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func signInTapped(_ sender: Any) {
        Authorization.global.signUp(vc: self, emailText: "greghughes988@gmail.com", password: "Hughes01!", passwordRetype: "Hughes01!", username: "greghughes988@gmail.com") { (confirmed) in
            if let confirmed = confirmed{
                print("good 🎸")
                DispatchQueue.main.async {
                self.performSegue(withIdentifier: "confirmID", sender: nil)
                }
            }
        }
    }
    @IBAction func signIn(_ sender: Any) {
        //        "Abc@123!"
        //        "gmhcode@gmail.com"
//        Authorization.global.signOut()
        Authorization.global.signIn(email: "greghughes988@gmail.com", password: "Hello!12", vc: self)
    }
  
    
}

