//
//  SideMenuExtension.swift
//  HyperApp
//
//  Created by Killvak on 08/12/2016.
//  Copyright © 2016 Killvak. All rights reserved.
//

import Foundation

extension HomePageVC : SWRevealViewControllerDelegate {

    
    
    func revealMenu() {
        sideMenuBOL.isEnabled  = true
        cartBarButton.isEnabled = true
        if L102Language.currentAppleLanguage() == "en" {
            
            if self.revealViewController() != nil {
                sideMenuBOL.target = self.revealViewController()
                sideMenuBOL.action = #selector(SWRevealViewController.revealToggle(_:))
                self.revealViewController().rearViewRevealWidth = self.view.frame.width * 0.75
                self.revealViewController().rightViewController.beginAppearanceTransition(false, animated: false)
                self.revealViewController().rightViewRevealOverdraw = 0.00
                self.revealViewController().rightViewRevealWidth = 0.00

                revealViewController().delegate = self
                revealViewController().tapGestureRecognizer()
                revealViewController().panGestureRecognizer()
            }
        } else {
            if self.revealViewController() != nil {
                sideMenuBOL.target = self.revealViewController()
                sideMenuBOL.action = #selector(SWRevealViewController.rightRevealToggle(_:))
                self.revealViewController().rightViewRevealWidth = self.view.frame.width * 0.75
                self.revealViewController().rearViewController.beginAppearanceTransition(false, animated: false)
                self.revealViewController().rearViewRevealOverdraw = 0.00
                self.revealViewController().rearViewRevealWidth = 0.00

                revealViewController().delegate = self
                revealViewController().tapGestureRecognizer()
                revealViewController().panGestureRecognizer()
            }
        }
    }
    
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        if L102Language.currentAppleLanguage() == "en" {
            if position == FrontViewPosition.right {
                revealController.frontViewController.view.isUserInteractionEnabled = false
                
            }
            else {
                revealController.frontViewController.view.isUserInteractionEnabled = true
                
            }
        }else {
            if position == FrontViewPosition.left {
                revealController.frontViewController.view.isUserInteractionEnabled = true
                
            }
            else {
                revealController.frontViewController.view.isUserInteractionEnabled = false
                
            }
        }
    }
    
    
}




extension MyProfileVC : SWRevealViewControllerDelegate {
    
    
    
    func revealMenu() {
        if L102Language.currentAppleLanguage() == "en" {
            
            if self.revealViewController() != nil {
                sideMenuBOL.target = self.revealViewController()
                sideMenuBOL.action = #selector(SWRevealViewController.revealToggle(_:))
                self.revealViewController().rearViewRevealWidth = self.view.frame.width * 0.75
                self.revealViewController().rightViewRevealWidth = 0.00
                self.revealViewController().rightViewController.beginAppearanceTransition(false, animated: false)
                self.revealViewController().rightViewRevealOverdraw = 0.00
                revealViewController().delegate = self
                revealViewController().tapGestureRecognizer()
                revealViewController().panGestureRecognizer()
            }
        } else {
            if self.revealViewController() != nil {
                sideMenuBOL.target = self.revealViewController()
                sideMenuBOL.action = #selector(SWRevealViewController.rightRevealToggle(_:))
                self.revealViewController().rightViewRevealWidth = self.view.frame.width * 0.75
                self.revealViewController().rearViewRevealWidth = 0.00
                self.revealViewController().rearViewController.beginAppearanceTransition(false, animated: false)
                self.revealViewController().rearViewRevealOverdraw = 0.00
                revealViewController().delegate = self
                revealViewController().tapGestureRecognizer()
                revealViewController().panGestureRecognizer()
            }
        }
    }
    
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        if L102Language.currentAppleLanguage() == "en" {
            if position == FrontViewPosition.right {
                revealController.frontViewController.view.isUserInteractionEnabled = false
                
            }
            else {
                revealController.frontViewController.view.isUserInteractionEnabled = true
                
            }
        }else {
            if position == FrontViewPosition.left {
                revealController.frontViewController.view.isUserInteractionEnabled = true
                
            }
            else {
                revealController.frontViewController.view.isUserInteractionEnabled = false
                
            }
        }
    }
    
    
}



extension FavListVC : SWRevealViewControllerDelegate {
    
    
    
    func revealMenu() {
        if L102Language.currentAppleLanguage() == "en" {
            
            if self.revealViewController() != nil {
                let sideMenuBOL = UIBarButtonItem(image: UIImage(named: "browsebutton"), style: .plain, target: self.revealViewController(), action: #selector(getter: UIDynamicBehavior.action)) // action:#selector(Class.MethodName) for swift 3
                
                self.navigationItem.leftBarButtonItem  = sideMenuBOL
                sideMenuBOL.target = self.revealViewController()
                sideMenuBOL.action = #selector(SWRevealViewController.revealToggle(_:))
                self.revealViewController().rearViewRevealWidth = self.view.frame.width * 0.75
                self.revealViewController().rightViewRevealWidth = 0.00
                self.revealViewController().rightViewController.beginAppearanceTransition(false, animated: false)
                self.revealViewController().rightViewRevealOverdraw = 0.00
                revealViewController().delegate = self
                revealViewController().tapGestureRecognizer()
                revealViewController().panGestureRecognizer()
            }
        } else {
            if self.revealViewController() != nil {
                let sideMenuBOL = UIBarButtonItem(image: UIImage(named: "browsebutton"), style: .plain, target: self.revealViewController(), action: #selector(getter: UIDynamicBehavior.action)) // action:#selector(Class.MethodName) for swift 3
                
                self.navigationItem.leftBarButtonItem  = sideMenuBOL
                sideMenuBOL.target = self.revealViewController()
                sideMenuBOL.action = #selector(SWRevealViewController.rightRevealToggle(_:))
                self.revealViewController().rightViewRevealWidth = self.view.frame.width * 0.75
                self.revealViewController().rearViewRevealWidth = 0.00
                self.revealViewController().rearViewController.beginAppearanceTransition(false, animated: false)
                self.revealViewController().rearViewRevealOverdraw = 0.00
                revealViewController().delegate = self
                revealViewController().tapGestureRecognizer()
                revealViewController().panGestureRecognizer()
            }
        }
    }
    
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        if L102Language.currentAppleLanguage() == "en" {
            if position == FrontViewPosition.right {
                revealController.frontViewController.view.isUserInteractionEnabled = false
                
            }
            else {
                revealController.frontViewController.view.isUserInteractionEnabled = true
                
            }
        }else {
            if position == FrontViewPosition.left {
                revealController.frontViewController.view.isUserInteractionEnabled = true
                
            }
            else {
                revealController.frontViewController.view.isUserInteractionEnabled = false
                
            }
        }
    }
    
    
}



extension OnCartVC : SWRevealViewControllerDelegate {
    
    
    
    func revealMenu() {
        if L102Language.currentAppleLanguage() == "en" {
            
            if self.revealViewController() != nil {
                let sideMenuBOL = UIBarButtonItem(image: UIImage(named: "browsebutton"), style: .plain, target: self.revealViewController(), action: #selector(getter: UIDynamicBehavior.action)) // action:#selector(Class.MethodName) for swift 3
                
                self.navigationItem.leftBarButtonItem  = sideMenuBOL
                sideMenuBOL.target = self.revealViewController()
                sideMenuBOL.action = #selector(SWRevealViewController.revealToggle(_:))
                self.revealViewController().rearViewRevealWidth = self.view.frame.width * 0.75
//                self.revealViewController().rightViewController.beginAppearanceTransition(false, animated: false)
//                self.revealViewController().rightViewRevealOverdraw = 0.00
                revealViewController().delegate = self
                revealViewController().tapGestureRecognizer()
                revealViewController().panGestureRecognizer()
            }
        } else {
            if self.revealViewController() != nil {
                let sideMenuBOL = UIBarButtonItem(image: UIImage(named: "browsebutton"), style: .plain, target: self.revealViewController(), action: #selector(getter: UIDynamicBehavior.action)) // action:#selector(Class.MethodName) for swift 3
                
                self.navigationItem.leftBarButtonItem  = sideMenuBOL
                sideMenuBOL.target = self.revealViewController()
                sideMenuBOL.action = #selector(SWRevealViewController.rightRevealToggle(_:))
                self.revealViewController().rightViewRevealWidth = self.view.frame.width * 0.75
//                self.revealViewController().rearViewRevealWidth = 0.00
//                self.revealViewController().rearViewController.beginAppearanceTransition(false, animated: false)
//                self.revealViewController().rearViewRevealOverdraw = 0.00
                revealViewController().delegate = self
                revealViewController().tapGestureRecognizer()
//                revealViewController().panGestureRecognizer()
                
            }
        }
    }
    
    func revealController(_ revealController: SWRevealViewController!, willMoveTo position: FrontViewPosition) {
        if L102Language.currentAppleLanguage() == "en" {
            if position == FrontViewPosition.right {
                revealController.frontViewController.view.isUserInteractionEnabled = false
                
            }
            else {
                revealController.frontViewController.view.isUserInteractionEnabled = true
                
            }
        }else {
            if position == FrontViewPosition.left {
                revealController.frontViewController.view.isUserInteractionEnabled = true
                
            }
            else {
                revealController.frontViewController.view.isUserInteractionEnabled = false
                
            }
        }
    }
    func revealControllerPanGestureShouldBegin(_ revealController: SWRevealViewController!) -> Bool {
        return false
    }
    
    
}
