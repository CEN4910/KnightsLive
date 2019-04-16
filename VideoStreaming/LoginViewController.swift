//
//  LoginViewController.swift
//  VideoStreaming
//
//  Created by Manny Cruz on 4/6/19.
//  Copyright © 2019 Nikil. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        //if user is already logged in switching to profile screen
        if defaultValues.string(forKey: "username") != nil{
            let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
    //The login script url make sure to write the ip instead of localhost
    //you can get the ip using ifconfig command in terminal
    let URL_USER_LOGIN = "http://10.173.90.70/api/ios/login.php"
    
    //the defaultvalues to store user data
    let defaultValues = UserDefaults.standard
    
    //the connected views
    //don't copy instead connect the views using assistant editor

    @IBOutlet weak var textFieldUserName: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    //the button action function
    @IBAction func buttonLogin(_ sender: UIButton) {
        
        //getting the username and password
        let parameters: Parameters=[
            "username":textFieldUserName.text!,
            "password":textFieldPassword.text!
        ]
        
        //making a post request
        Alamofire.request(URL_USER_LOGIN, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    
                    //if there is no error
                    if(!(jsonData.value(forKey: "error") as! Bool)){
                        
                        //getting the user from response
                        let user = jsonData.value(forKey: "user") as! NSDictionary
                        
                        //getting user values
                        let userId = user.value(forKey: "id") as! Int
                        let userName = user.value(forKey: "username") as! String
                        let userEmail = user.value(forKey: "email") as! String
                        let userPhone = user.value(forKey: "phone") as! String
                        
                        //saving user values to defaults
                        self.defaultValues.set(userId, forKey: "userid")
                        self.defaultValues.set(userName, forKey: "username")
                        self.defaultValues.set(userEmail, forKey: "useremail")
                        self.defaultValues.set(userPhone, forKey: "userphone")
                        
                        //switching the screen
                        self.performSegue(withIdentifier: "successLoginSegue", sender: self)

                    }else{
                        //error message in case of invalid credential
                       print("Invalid username or password")
                    }
                }
        }
    }
    

    @IBAction func signUpButton(_ sender: UIButton) {
        performSegue(withIdentifier: "signUpSegue", sender: self)
    }
    

}
