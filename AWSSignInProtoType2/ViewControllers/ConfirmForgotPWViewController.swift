//
//  ConfirmForgotPWViewController.swift
//  AWSSignInProtoType2
//
//  Created by Greg Hughes on 3/29/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit

class ConfirmForgotPWViewController: UIViewController {
 
    @IBOutlet weak var confirmationCodeTextField: UITextField!
    @IBOutlet weak var newPasswordTextFIeld: UITextField!
    
    @IBOutlet weak var retypeNewPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updatePasswordTapped(_ sender: Any) {
        
        Authorization.global.newPassword(email: "greghughes988@gmail.com", newPassword: "Hello!12", reTypePassword: "Hello!12", confirmationCode: confirmationCodeTextField.text, vc: self) { (state) in
            guard let state = state else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}
            

        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
