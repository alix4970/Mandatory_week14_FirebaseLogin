//
//  FacebookManager.swift
//  FirebaseLogin
//
//  Created by Ali Al sharefi on 04/04/2020.
//  Copyright © 2020 Ali Al sharefi. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

class FacebookManager{
    
    let parentVC:ViewController
    
    init(parentVC:ViewController) {
        self.parentVC = parentVC
    }
    
    func loginToFacebook(){
        print("FB login works!")
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile], viewController: parentVC) { (result) in
                print("Logged in to facebook\(result)")
            
            switch result{
            case .cancelled:
                print("Login was cancelled")
                break
            case .failed(let error):
                print("login failed\(error.localizedDescription)")
                break
            case let .success(granted: _, declined: _, token: token):
                print("facebok login success\(token.userID)")
                self.parentVC.firebaseManager?.signInUsingFacebook(tokenString: token.tokenString)
            }
        }
    }
    
    func makeGraphRequest(){
        if let tokenStr = AccessToken.current?.tokenString{
            let graphRequest = GraphRequest(graphPath: "/me", parameters: ["fields":"id,name,email, picture.width(400)"], tokenString: tokenStr, version: Settings.defaultGraphAPIVersion, httpMethod: .get)
            
            let connection = GraphRequestConnection()
            connection.add(graphRequest) { (connection, result, error) in
                if error == nil, let res = result{
                    let dict = res as! [String:Any] //cast to dictionary
                    let name = dict["name"] as! String
                    //let email = dict["email"] as! String - my own email dosent show up in firebase? ask Jon
                    print("Got data from facebook. Name \(name)")
                    print(dict)
                }else{
                    print("error getting data from facebook\(error.debugDescription)")
                }
            }
            connection.start()
        }
    }
    
}
