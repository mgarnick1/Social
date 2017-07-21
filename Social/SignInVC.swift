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



class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            }
            
        })
    }
}

