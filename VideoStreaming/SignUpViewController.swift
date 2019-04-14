//
//  SignUpViewController.swift
//  VideoStreaming
//
//  Created by Manny Cruz on 4/6/19.
//  Copyright © 2019 Nikil. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var fullName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func doneSignUpBtn(_ sender: Any) {
        if((self.presentingViewController) != nil){
            self.dismiss(animated: false, completion: nil)
            print("done")
        }
    }
    
    // the button action function
    @IBAction func sginUp(_ sender: Any)
    {
        let url = URL(string: "http://3.210.109.51/api/receive.php") // locahost MAMP - change to point to your database server
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        var dataString = "secretWord=44fdcv8jf3" // starting POST string with a secretWord
        
        // the POST string has entries separated by &
        
        dataString = dataString + "&fullname=\(fullName.text!)" // add items as name and value
        dataString = dataString + "&email=\(email.text!)"
        dataString = dataString + "&password=\(password.text!)"
     
        // convert the post string to utf8 format
        
        let dataD = dataString.data(using: .utf8) // convert to utf8 string
        
        do
        {
            
            // the upload task, uploadJob, is defined here
            
            let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD)
            {
                data, response, error in
                
                if error != nil {
                    
                    // display an alert if there is an error inside the DispatchQueue.main.async
                    
                    DispatchQueue.main.async
                        {
                            let alert = UIAlertController(title: "Upload Didn't Work?", message: "Looks like the connection to the server didn't work.  Do you have Internet access?", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                    }
                }
                else
                {
                    if let unwrappedData = data {
                        
                        let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) // Response from web server hosting the database
                        
                        if returnedData == "1" // insert into database worked
                        {
                            
                            // display an alert if no error and database insert worked (return = 1) inside the DispatchQueue.main.async
                            
                            DispatchQueue.main.async
                                {
                                    let alert = UIAlertController(title: "Upload OK?", message: "Looks like the upload and insert into the database worked.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            // display an alert if an error and database insert didn't worked (return != 1) inside the DispatchQueue.main.async
                            
                            DispatchQueue.main.async
                                {
                                    
                                    let alert = UIAlertController(title: "Upload Didn't Work", message: "Looks like the insert into the database did not worked.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
            uploadJob.resume()
        }
    }
    
}
