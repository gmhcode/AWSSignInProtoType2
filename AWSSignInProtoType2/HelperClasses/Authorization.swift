//
//  Authorization.swift
//  AWSSignInProtoType2
//
//  Created by Greg Hughes on 3/28/20.
//  Copyright © 2020 Greg Hughes. All rights reserved.
//

import UIKit
import AWSMobileClient

var theUser : User!
struct Authorization {
    
    static var global = Authorization()
    var theUser : User!
    
    func initialize() {
        AWSMobileClient.default().initialize { (userState, error) in
            if let userState = userState {
                print("UserState: \(userState.rawValue)")
            } else if let error = error {
                print("error: \(error.localizedDescription)")
            }
        }
    }
    
    func signUp(vc:UIViewController,emailText:String?,password:String?,passwordRetype: String?,username:String?, completion: @escaping(ConfirmationState?)->Void){
        guard let emailText = emailText,
            let passwordText = password,
            let retypePassword = passwordRetype,
            let username = username else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}

        
        if passwordText != retypePassword {
            // Show passwords do not match alert
            self.passwordDontMatchAlert(vc: vc)
            completion(nil)
        }
        
        let user = User(email: emailText, uuid: UUID().uuidString, username: username, password: passwordText)
        
        AWSMobileClient.default().signUp(username: user.email,
                                         password: user.password,
                                         userAttributes: ["email":user.email,"custom:uuid":user.uuid]) { (signUpResult, error) in
            if let signUpResult = signUpResult {
                
                switch(signUpResult.signUpConfirmationState) {
                case .confirmed:
                    print("🏊🏾‍♂️ User is signed up and confirmed.")
                //TODO : Alert saying the user already exists
                    self.confirmedEmailExistsAlert(vc: vc)
                    completion(nil)
                    
                    
                case .unconfirmed:
                    
                    print("🚣🏼‍♂️ User is not confirmed and needs verification via \(signUpResult.codeDeliveryDetails!.deliveryMedium) sent at \(signUpResult.codeDeliveryDetails!.destination!)")
                    
                    Authorization.global.theUser = user
                    completion(.emailWillBeSent)
                    
                case .unknown:
                    print("Unexpected case")
                    completion(nil)
                }
            } else if let error = error {
                if let error = error as? AWSMobileClientError {
                    switch(error) {
                    case .usernameExists(let message):
                        print(message, " 🥇")
                         //TODO : Alert saying the user already exists
                        self.unconfirmedEmailExistsAlert(vc: vc)
                    default:
                        break
                    }
                    
                }
                print("\(error.localizedDescription)")
                completion(nil)
            }
        }
    }
    
    func passwordDontMatchAlert(vc:UIViewController) {
        let alertController = UIAlertController(title: "Invalid Passwords", message: "The passwords do not match", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okButton)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    func confirmedEmailExistsAlert(vc:UIViewController) {
        let alertController = UIAlertController(title: "Email Already Exists", message: "An account with the given email already exists and is confirmed ", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel) { (ok) in
            ///  segue to confirmation VC :
            
            
        }
        alertController.addAction(okButton)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    func unconfirmedEmailExistsAlert(vc:UIViewController) {
        DispatchQueue.main.async {
        let alertController = UIAlertController(title: "Email Already Exists", message: "An account with the given email already exists and is unconfirmed ", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(okButton)
//        alertController.show()
            vc.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    enum ConfirmationState {
        case emailWillBeSent
    }
}
public extension UIAlertController {
//    will present alert no matter which view controller the user is on
    func show() {
//        DispatchQueue.main.async {
            let win = UIWindow(frame: UIScreen.main.bounds)
            let vc = UIViewController()
            vc.view.backgroundColor = .clear
            win.rootViewController = vc
            win.windowLevel = UIWindow.Level.alert + 1
            win.makeKeyAndVisible()
            vc.present(self, animated: true, completion: nil)
//        }
        
    }
}
