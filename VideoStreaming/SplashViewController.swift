//
//  SplashViewController.swift
//  VideoStreaming
//
//  Created by Emmanuel on 01/20/19.

import UIKit

class SplashViewController: UIViewController {

    var scheduleList = [Schedule]()
    var videoStreamURLSample = StremModel()
    
    @IBOutlet weak var SplashLogo: UIImageView!
    
    
    var videoStreamUrl : String = ""
    
    var scheduleProgramList = [Schedule]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        AppUtility.lockOrientation(.portrait)

        SplashLogo.image = #imageLiteral(resourceName: "splashlogo")
        
        if videoStreamURLfromApi_endpoint == ""
        {
            videoStreamUrl = videoStreamURL
            
            self.getSheduleUrl()
        }
        else
        {
            self.getStremingUrl()
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getStremingUrl()
    {
        if Connectivity.isConnectedToInternet() {
            
            print("Yes! internet is available.")
            // do some tasks..
            
            
            DispatchQueue.global(qos: .background).async {
                
                
                WebServiceManager.sharedInstance.getStremUrl(){ (status, message, responseObject, error) in
                    
                    print("new status \(status)")
                    
                    if(status == true)
                        
                    {
  
                            self.videoStreamURLSample = responseObject as! StremModel
                            self.videoStreamUrl =  self.videoStreamURLSample.URL
                        
                        
                        
                        self.getSheduleUrl()
                        
                    }
                    else
                    {
                        var alert = UIAlertView(title: "Entry Missing", message: "Please provide base URL and schedule URL to go further", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                        print ("give schedule url")
                    }
                }
            }
        }
            
        else
        {
            
            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }

    }
    
    
    func getSheduleUrl()
    {
        // Set the timer for delay to load Home screen
        
        if Connectivity.isConnectedToInternet() {
            
            print("Yes! internet is available.")
            // do some tasks..
            
            
 
                
                
                WebServiceManager.sharedInstance.getSchdule(){ (status, message, responseObject, error) in
                    
                    print("new status \(status)")
                    
                    if(status == true)
                        
                    {
                        
                        self.scheduleList = responseObject as! [Schedule]
                        
                        self.scheduleProgramList = self.scheduleList
                        
                        print("AR LIST ")
                        
//                        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.navigateToHomeScreen), userInfo: nil, repeats: false)
                        self.navigateToHomeScreen()
                    }
                    else
                    {
                        var alert = UIAlertView(title: "Entry Missing", message: "Please provide base URL and schedule URL to go further", delegate: nil, cancelButtonTitle: "OK")
                        alert.show()
                        print ("give schedule url")
                    }
                }

        }
            
        else
        {
            
            
            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
            
        }
  
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarHidden(true, with: UIStatusBarAnimation.none)
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        UIApplication.shared.setStatusBarHidden(false, with: UIStatusBarAnimation.none)
    }
    
    
 //   override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
 //       return UIInterfaceOrientationMask.portrait //return the value as per the required orientation
 //   }
    
 //   override var shouldAutorotate: Bool {
  //      return false
  //  }
    
    // Navigate to home screen after delay
    
    
    func navigateToHomeScreen()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        var storyboard:UIStoryboard!
        
        
        if(AppController.UserInterfaceIdiom == AppController.DEVICE_IPHONE){
            
            storyboard = UIStoryboard(name: "Main_Iphone", bundle: nil)
            
            
        }
        else
        {
            
            storyboard = UIStoryboard(name: "Main_Ipad", bundle: nil)
            
        }
        
        appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
        
        let controller = storyboard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
        controller.videoStreamUrl = videoStreamUrl
        controller.scheduleProgramList = scheduleProgramList
        //        let navi = UINavigationController(rootViewController:controller)
        //        navi.isNavigationBarHidden = true
        //        self.present(controller, animated: true, completion: nil)
        
        DispatchQueue.main.async {
            appDelegate.window?.rootViewController = controller
        }
        
    }
   
    
   
    


}
