//
//  AppDelegate.swift
//  VideoStreaming
//
//  Created by Nikil on 11/01/18.
//  Copyright © 2018 Nikil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var orientationLock = UIInterfaceOrientationMask.all


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if (UI_USER_INTERFACE_IDIOM() ==  .pad)
        {
            AppController.UserInterfaceIdiomIPad = true
        }
        else if (UI_USER_INTERFACE_IDIOM() ==  .phone)
        {
            AppController.UserInterfaceIdiomIPad = false

        }
        
        if (UI_USER_INTERFACE_IDIOM() ==  .pad)
        {
            // Place iPad specific code here...

            AppController.UserInterfaceIdiom = AppController.DEVICE_IPAD

            print("I PAD = \(AppController.UserInterfaceIdiom)")

            self.window = UIWindow(frame: UIScreen.main.bounds)

            let storyboard = UIStoryboard(name: "Main_Ipad", bundle: nil)

            let controller = storyboard.instantiateViewController(withIdentifier: "splashViewController")


            // let controller = SplashViewController.instantiateViewControllerFromStoryboard(storyBoardName: "Main_Ipad")

            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()






        } else if (UI_USER_INTERFACE_IDIOM() ==  .phone) {

            // Place iPhone-specific code here...

            AppController.UserInterfaceIdiom = AppController.DEVICE_IPHONE

            print("I PHONE \(AppController.UserInterfaceIdiom)")

            self.window = UIWindow(frame: UIScreen.main.bounds)


            let storyboard = UIStoryboard(name: "Main_Iphone", bundle: nil)

            let controller = storyboard.instantiateViewController(withIdentifier: "splashViewController")

            //let controller = SplashViewController.instantiateViewControllerFromStoryboard(storyBoardName: "Main_Iphone")

            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()

        }
        
        
        return true
        
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}
struct AppUtility {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
    
}


