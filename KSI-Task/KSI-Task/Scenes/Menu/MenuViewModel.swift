//
//  MenuViewModel.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 06/02/2024.
//

import Foundation
import RxSwift
import RxCocoa

class MenuVCViewModel:ViewModel {
    var hasErrInTxt: PublishSubject<String> = .init()
    var isLoading: BehaviorRelay<Bool> = .init(value:false)
}

