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
            let viewModel = HomeVCViewModel(getProductListUsecase: DefaultGetProductListUsecase(homeRepo: DefaultHomeRepo(productListLDBCLient: ProductListLDBCLient.shared)),productItemFavUsecase: DefaultProductItemFavUsecase(homeRepo: DefaultHomeRepo(productListLDBCLient: ProductListLDBCLient.shared)))
            return HomeVC(viewModel: viewModel, coordinator: coordinator)
        case .menu:
            return UIViewController()
        case .favourite:
            return UIViewController()
        case .cart:
            return UIViewController()
        case .profile:
            return UIViewController()
        default:
           return UIViewController()
        }
    }
}
