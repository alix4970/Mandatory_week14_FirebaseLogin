//
//  ViewController.swift
//  FirebaseLogin
//
//  Created by Ali Al sharefi on 04/04/2020.
//  Copyright © 2020 Ali Al sharefi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookLogin //is required for the login process
import FacebookCore //is requred for the Graphrequest

class ViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    var firebaseManager:FirebaseManager?
    var facebookManager:FacebookManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager = FirebaseManager(parentVC: self) //enable firebaseManager to update GUI
        facebookManager = FacebookManager(parentVC: self)

    }
    
    func presetSecretVC(){
        performSegue(withIdentifier: "secretSegue", sender: self)
    }

    @IBAction func signUpBtnPressed(_ sender: UIButton) {
        if verify().isOK{
            firebaseManager?.signUp(email: verify().email, pwd: verify().pwd)
        }
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        //do not hide content based on this method call. do that in the listener
        firebaseManager?.signOut()
        presetSecretVC()
    }
    
    
    @IBAction func signInPressed(_ sender: UIButton) {
        if verify().isOK{
            firebaseManager?.signIn(email: verify().email, pwd: verify().pwd)
        }
        
}
    
    @IBAction func facebookLoginPressed(_ sender: Any) {
        facebookManager?.loginToFacebook()

    }
    
//make Graph request for user data
    // in similar way, you can get user news feed
    @IBAction func loadFacebookDataPressed(_ sender: UIButton) {
        facebookManager?.makeGraphRequest()
    }
    
    
    func verify() -> (email:String, pwd:String, isOK:Bool) {
        if let email = emailField.text, let pwd = passwordField.text{
            if email.count > 5 && pwd.count > 5{
                return (email,pwd,true)
            }
        }
        return("","",false) //tuple, containing 3 values
    }
    
    
}



