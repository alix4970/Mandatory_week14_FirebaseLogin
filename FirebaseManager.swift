//
//  FirebaseManager.swift
//  FirebaseLogin
//
//  Created by Ali Al sharefi on 04/04/2020.
//  Copyright © 2020 Ali Al sharefi. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseManager{
    var auth = Auth.auth() //firebase authentication class
    let parentVC:ViewController

    
    init(parentVC: ViewController) {
        self.parentVC = parentVC
        auth.addIDTokenDidChangeListener { (auth, user) in
            if user != nil{
                print("Status: User is logged in: \(user)")
            }else{
                print("Status: User is logged out")
                
                //hide the secretVC here - do it later
            }
        }
    }
    
    func signUp(email:String, pwd:String){
        auth.createUser(withEmail: email, password: pwd) { (result, error) in
            if error == nil{
                print("succesfully signed up to Firebase\(result.debugDescription)")
            }else{
                print("Failed to sign up\(result.debugDescription)")
            }
        }
    }
    
    func signIn(email:String, pwd:String){
        auth.signIn(withEmail: email, password: pwd) { (result, error) in
                        if error == nil{
                print("succesfully logged in to Firebase\(result.debugDescription)")
                            //call parentVC to display something parentVC.showPanel()
                            self.parentVC.presetSecretVC()
            }else{
                print("Failed to log in\(result.debugDescription)")
            }
        }
    }
    
    func signInUsingFacebook(tokenString:String) {
        //call firebase, using credentials from facebook.
        let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
        auth.signIn(with: credential) { (result, error) in
            if error == nil{
            print("logged in to firebase, using facebook\(result?.description)")
            }else{
                print("Failed to log in to firebase using facebook\(error.debugDescription)")
            }
        }
    }
    
    func signOut(){
        do{
        try auth.signOut()
        }catch let error{
            print("Error signing out\(error.localizedDescription)")
        }
    }
    
    
}
