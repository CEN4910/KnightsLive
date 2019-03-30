//
//  HomeViewController.swift
//  VideoStreaming
//
//  Created by Nikil on 11/01/18.
//  Copyright © 2018 Nikil. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tabStream: UITabBarItem!
    
    @IBOutlet weak var tabPrograms: UITabBarItem!
    
    @IBOutlet weak var tabAboutus: UITabBarItem!
    
    
    @IBOutlet weak var tabBarMenu: UITabBar!
    
    @IBOutlet weak var viewTabBar: UIView!
    
    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet weak var tabBarViewHeightConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var viewTabBarHeight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var buttonFullScreenDummy: UIButton!
    
    @IBOutlet weak var imageViewFullScreenDummy: UIImageView!
    
    var scheduleList = [Schedule]()
    
    var scheduleProgramList = [Schedule]()
    
    var programsViewController: ProgramsViewController!
    
    
    var streamViewController: StreamViewController!
    
    
    var aboutViewController: AboutViewController!
    
    
    
    var videoStreamUrl : String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        
        self.tabBarMenu.delegate = self
        
        self.tabBarMenu.selectedItem = self.tabStream
        
        
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().tintColor = hexToUiColor().hexStringToUIColor(hex: programcurrentdateColor)
        UITabBar.appearance().backgroundColor = UIColor.black
        tabBarMenu.backgroundColor =  hexToUiColor().hexStringToUIColor(hex: tabSelectionColor)

        tabStream.title = NSLocalizedString("tab1_title", comment: "Title of the Tab")//title_Tab1
        tabPrograms.title = NSLocalizedString("tab2_title", comment: "Title of the Tab")//title_Tab2
        tabAboutus.title = NSLocalizedString("tab3_title", comment: "Title of the Tab")//title_Tab3
        
        self.tabBarMenu.itemSpacing = UIScreen.main.bounds.width / 5

        self.setupViewControllers()
        
        self.setupView()
        
//        containerView.backgroundColor = UIColor.red
        

     
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
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
    
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
//    {
//        return UIInterfaceOrientationMask.portrait //return the value as per the required orientation
//    }
//    
//    override var shouldAutorotate: Bool
//    {
//        return false
//    }
    
  
    
    // Add Child view Controller to  Master view controller
    @IBAction func buttonFullScreenDummyAction(_ sender: Any) {
        
        
        
        
        
    }
    
    func add(asChildViewController viewController: UIViewController)
    {
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        self.containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = self.containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    // Remove Child view Controller to  Master view controller
    
    
    func remove(asChildViewController viewController: UIViewController)
    {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
 

}

//user interactions
extension HomeViewController
{
   
  
}

//pvt functions
extension HomeViewController
{
    func setupView()
    {
       
        updateView()
       
    }
    func setupViewControllers()
    {
        
        
        var storyboard:UIStoryboard!
        
        
        if AppController.UserInterfaceIdiom == AppController.DEVICE_IPHONE
        {
            
            storyboard = UIStoryboard(name: "Main_Iphone", bundle: Bundle.main)
            
        }
            
        else if AppController.UserInterfaceIdiom == AppController.DEVICE_IPAD
        {
            
            storyboard = UIStoryboard(name: "Main_Ipad", bundle: Bundle.main)
            
        }
        
        
        
        programsViewController = storyboard.instantiateViewController(withIdentifier: "programsViewController") as! ProgramsViewController
        programsViewController.scheduleProgramList = scheduleProgramList
        self.add(asChildViewController: programsViewController)
        
        streamViewController = storyboard.instantiateViewController(withIdentifier: "streamViewController") as! StreamViewController
        streamViewController.videoStreamUrl = videoStreamUrl
        streamViewController.scheduleProgramList = scheduleProgramList
        
        self.add(asChildViewController: streamViewController)
        
        
        aboutViewController = storyboard.instantiateViewController(withIdentifier: "aboutViewController") as! AboutViewController
        self.add(asChildViewController: aboutViewController)
        
    }
    
    // Show TabBar
    
    public func showTabBarMenu()
    {
        
        //  self.containerView.frame = self.view.frame
        
        
    }
    
    // Hide TabBar
    
    
    public func hideTabBarMenu()
    {
        
        self.containerView.frame = self.view.frame
        
        
    }
    // Update the view with Child view controller
    
    
   func updateView()
    {
        
        if tabBarMenu.selectedItem == tabStream
        {
          
            remove(asChildViewController: programsViewController)
            remove(asChildViewController: aboutViewController)
            add(asChildViewController: streamViewController)

        }
        else if tabBarMenu.selectedItem == tabPrograms
        {
          
            remove(asChildViewController: streamViewController)
            remove(asChildViewController: aboutViewController)
            add(asChildViewController: programsViewController)

        }
            
        else if tabBarMenu.selectedItem == tabAboutus
        {
          
            remove(asChildViewController: programsViewController)
            remove(asChildViewController: streamViewController)
            add(asChildViewController: aboutViewController)


        }
        
    }//end of method
}

//tabbar delegate methods
extension HomeViewController:UITabBarDelegate
{
    
    // Action for each tab
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        
        
        if Connectivity.isConnectedToInternet() {
            print("Yes! internet is available.")
            
            // do some tasks..
            
            if tabBar.selectedItem == tabStream {
              
                remove(asChildViewController: programsViewController)
                remove(asChildViewController: aboutViewController)
                add(asChildViewController: streamViewController)

                AppUtility.lockOrientation(.all)

            }
            else if tabBar.selectedItem == tabPrograms {
               
                remove(asChildViewController: streamViewController)
                remove(asChildViewController: aboutViewController)
                add(asChildViewController: programsViewController)
                AppUtility.lockOrientation(.portrait)

            }
                
            else if tabBar.selectedItem == tabAboutus {
               
                remove(asChildViewController: programsViewController)
                remove(asChildViewController: streamViewController)
                add(asChildViewController: aboutViewController)
                AppUtility.lockOrientation(.portrait)

            }
        
        }
        else{
            
            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
            
        }

    }
  
}
