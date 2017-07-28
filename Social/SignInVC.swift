//
//  ViewController.swift
//  Social
//
//  Created by Shoenick on 7/14/17.
//  Copyright © 2017 Shoenick. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper




class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.stringForKey(KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
    }


    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.login(withReadPermissions: ["email"], from: self)  { (result, error) in
            if error != nil {
                print("Jess: Unable to authenticate with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("Jess: User cancelled facebook authentication")
            } else {
                print("Jess: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                
            }
        
        }
    }
    
    func firebaseAuth(_ credential: FirebaseAuthCredential) {
        firebaseAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("Jess: unable to authenticate with Firebase \(error)")
            } else {
                print("Jess: successfully authenticated with Firebase")
                if let user = user {
                    let userData = ["provider"!, credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData)
                }
                
            }
            
        })
    }
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text, let pwd = pwdField.text {
            firebaseAuth.signIn(withEmail: email, password: pwd, completeion: {(user, error) in
                if error == nil {
                    print("Jess: Email user authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider"!, user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    firebaseAuth()?.createUser(withEmail: email, password: pwd, completeion: {(user, error) in
                        if error != nil {
                            print("Jess: Unable to authenticate with Firebase using email")
                        } else {
                            print("Jess: Successfully authenticated with Firebase")
                            if let user = user {
                                let userData = ["provider"!, user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                            
                        }
                        
                    })
                }
            }
        
        )}

    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        let keychainResult = KeychainWrapper.standard.setString(id, forKey: KEY_UID)
        print("Jess: Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }
    
    
}

