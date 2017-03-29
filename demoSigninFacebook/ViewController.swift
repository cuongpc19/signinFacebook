//
//  ViewController.swift
//  demoSigninFacebook
//
//  Created by AgribankCard on 3/29/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit

class ViewController: UIViewController,FBSDKLoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.center = self.view.center
        loginButton.readPermissions = ["public_profile","email","user_friends"]
        self.view.addSubview(loginButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (FBSDKAccessToken.current() != nil) {
            print("User login: \(FBSDKAccessToken.current().userID)")
            let graphrequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email"])
            graphrequest?.start(completionHandler: { (connection, result, error) -> Void in
                if ((error) != nil)
                {
                    print(error)
                }
                else
                {                    
                    let datares = result as! [String: Any]
                    let email = datares["email"] as! String
                    print("email: \(email)")
                }
            })
        }
    }
    
    
    /**
     Sent to the delegate when the button was used to logout.
     - Parameter loginButton: The button that was clicked.
     */
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        if (FBSDKAccessToken.current() == nil) {
            print("User logout")
        }
    }

    
}

