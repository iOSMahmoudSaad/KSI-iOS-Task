//
//  MainTabBar.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import UIKit


class CustomTabBar: UITabBar {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    private func setupView(){
       // barTintColor = .blue
        backgroundColor = .black
        barTintColor = .white
        isTranslucent = false
    }
}


enum TabBarItems:Int,CaseIterable {
    case Home
    case Menu
    case Cart
    case Favourite
    case Profile
}

class MainTabBar: UITabBarController {
    var coordinator:Coordinator

    init(coordinator:Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(CustomTabBar(), forKey: "tabBar")
        self.tabBar.tintColor = .lavenderPurple
        self.tabBar.unselectedItemTintColor = .white
        setupTabBar()
    }
    
    private func setupTabBar(){
        viewControllers = TabBarItems.allCases.map({
            let view =  createViewControllerFor($0)
            let navigation = UINavigationController(rootViewController: view)
            navigation.navigationBar.isHidden = true
            navigation.hidesBottomBarWhenPushed = true
            return navigation
        })
    }
    
    private func createViewControllerFor(_ item:TabBarItems)->UIViewController{
        switch item {
        case .Home:
            let vc = coordinator.main.viewController(for: .home)
            vc.tabBarItem = createTabBarItem(for: item)
            return vc
        case .Menu:
            let vc = coordinator.main.viewController(for: .menu)
            vc.tabBarItem = createTabBarItem(for: item)
            return vc
        case .Cart:
            let vc = coordinator.main.viewController(for: .cart)
            vc.tabBarItem = createTabBarItem(for: item)
            return vc
        case .Favourite:
            let vc = coordinator.main.viewController(for: .favourite)
            vc.tabBarItem = createTabBarItem(for: item)
            return vc
        case .Profile:
            let vc = coordinator.main.viewController(for: .profile)
            vc.tabBarItem = createTabBarItem(for: item)
            return vc
        }
    }
    private func createTabBarItem(for item: TabBarItems)-> UITabBarItem?{
        let tabBarItem:UITabBarItem
        switch item {
        case .Home:
            tabBarItem = .init(title: nil, image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        case .Menu:
            tabBarItem = .init(title: nil, image: UIImage(named: "menu"), selectedImage: UIImage(named: "menu"))
        case .Cart:
            tabBarItem = .init(title: nil, image: UIImage(named: "cart"), selectedImage: UIImage(named: "cart"))
        case .Favourite:
            tabBarItem = .init(title: nil, image: UIImage(named: "heart"), selectedImage: UIImage(named: "heart"))
        case .Profile:
            tabBarItem = .init(title: nil, image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile"))
        }
        
        //        tabBarItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 15)
      // tabBarItem.imageInsets = .init(top: 10, left: 0, bottom: -10, right: 0)
        
        return tabBarItem
        
    }
}
