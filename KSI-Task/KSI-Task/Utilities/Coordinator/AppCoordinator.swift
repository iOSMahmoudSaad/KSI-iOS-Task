//
//  AppCoordinator.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import UIKit

class AppCoordinator:Coordinator{
    
    var window:UIWindow
    
    lazy var main: MainNavigator = {
        return .init(coordinator: self)
    }()
    
    lazy var splahScreen: UIViewController = {
        return UINavigationController(rootViewController: MainTabBar(coordinator: self))
    }()
    
    var navigationController:UINavigationController? {
       if let nav = splahScreen as? UINavigationController {
           
           nav.navigationBar.isHidden = true
           return nav
       } else {
           return nil
       }
       
    }
    var rootViewController:UIViewController {
        
        return splahScreen
    }
    
    init(window:UIWindow) {
        
        self.window = window
        
    }
    
    func start(){
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}
