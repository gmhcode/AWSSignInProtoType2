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
        Authorization.global.signUp(vc: self, emailText: "gmhcode@gmail.com", password: "Hughes01!", passwordRetype: "Hughes01!", username: "gmhcode@gmail.com") { (confirmed) in
            if let confirmed = confirmed{
                print("good 🎸")
            }
        }
    }
}

