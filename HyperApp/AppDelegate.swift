    //
    //  AppDelegate.swift
    //  HyperApp
    //
    //  Created by Killvak on 09/10/2016.
    //  Copyright © 2016 Killvak. All rights reserved.
    //
    
    import UIKit
    import GoogleSignIn
    import Onboard
    import FBSDKCoreKit
    @UIApplicationMain
    class AppDelegate: UIResponder, UIApplicationDelegate {
        
        var window: UIWindow?
        
        
        func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
            let googleDidHandle =  GIDSignIn.sharedInstance().handle(url,
                                                                     sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String,
                                                                     annotation: options[UIApplicationOpenURLOptionsKey.annotation])
            
            let FBhandled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
            
            return googleDidHandle || FBhandled
            
            
        }
        
        
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
            L102Localizer.DoTheMagic()

            return true
        }
        
        //    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //        // Override point for customization after application launch.
        //
        //        let firstPage = OnboardingContentViewController(title: "Hyper Techno", body: "The fastest delivery Ever", image: UIImage(named:"yellow"), buttonText: nil) { () -> Void in       }
        //        firstPage.titleLabel.textColor = UIColor.orange
        //
        //        let secondPage = OnboardingContentViewController(title: "Hyper Techno", body: "why bother driving if u can Order Now", image: UIImage(named:"red"), buttonText: "Let's get Started") { () -> Void in
        //            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //            let initViewController: LoginVC = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        //            self.window?.rootViewController? = initViewController
        //        }
        //        secondPage.titleLabel.textColor = UIColor.red
        //        // Image
        //        let onboardingVC = OnboardingViewController(backgroundImage: UIImage(named: "1"), contents: [firstPage, secondPage])
        //        window?.rootViewController = onboardingVC
        //        return true
        //    }
        
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
        
        
        
        func reloadApp() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            self.window?.rootViewController = storyboard.instantiateInitialViewController()
        }
        
        func saveUserLogginData(email:String?,photoUrl : String?) {
            
            if   let email = email   {
                UserDefaults.standard.setValue(email, forKey: "userEmail")
            }else{
                UserDefaults.standard.setValue(nil, forKey: "userEmail")
                
            }
            
            if  let photo = photoUrl {
                UserDefaults.standard.setValue(photo, forKey: "profileImage")
            }else {
                UserDefaults.standard.setValue(nil, forKey: "profileImage")
            }
        }
        
        func isUserLoggedIn() -> Bool {
            if (UserDefaults.standard.value(forKey: "userEmail") != nil) {
                return true
            }else {
                return false 
            }
            
        }
        
        
    }
    let ad = UIApplication.shared.delegate as! AppDelegate
    
    
    
    
