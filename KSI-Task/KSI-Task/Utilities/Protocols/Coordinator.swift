//
//  Coordinator.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import UIKit


protocol Coordinator {
    var main: MainNavigator { get }
    var navigationController:UINavigationController? { get }
}
