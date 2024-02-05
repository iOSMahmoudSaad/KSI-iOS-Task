//
//  MainNavigators.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import UIKit


class MainNavigator:Navigator {
    
    var coordinator: Coordinator
    
    enum Destination {
        case home
        case menu
        case favourite
        case cart
        case profile
        
    }
    
    required init(coordinator: Coordinator) {
        
        self.coordinator = coordinator
    }
    
    func viewController(for destination: Destination) -> UIViewController {
        
        switch destination {
        case .home:
           print("Home")
        case .menu:
            print("menu")
        case .favourite:
            print("favourite")
        case .cart:
            print("cart")
        case .profile:
            print("profile")
        default:
           return UIViewController()
        }
    }
}
