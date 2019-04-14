//
//  LoginViewController.swift
//  VideoStreaming
//
//  Created by Manny Cruz on 4/6/19.
//  Copyright © 2019 Nikil. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    

    @IBAction func signUpButton(_ sender: UIButton) {
        performSegue(withIdentifier: "signUpSegue", sender: self)
    }
    

}
