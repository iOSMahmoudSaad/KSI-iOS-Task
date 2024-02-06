//
//  ProductDetailsVCVieMode.swift
//  KSI-Task
//
//  Created by Mahmoud Saad  on 06/02/2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol ProductDetailsVCVieModelOutput {
    
    var imagesItems:BehaviorRelay<[String]>{get set}
    var productDetailsSub:PublishSubject<ProductDetails> {get set}
    var selelctedImage:PublishSubject<String>{get set}
    func viewDidLoad()
}
protocol ProductDetailsVCVieModelInput {
    
    var id:String {get set}
    var repo:ProductDetailsRepo {get set}
    func selectedImage(index:Int)
}

class ProductDetailsVCVieModel:ViewModel,ProductDetailsVCVieModelInput,ProductDetailsVCVieModelOutput {
    
    var isLoading: BehaviorRelay<Bool> = .init(value: false)
    var hasErrInTxt: PublishSubject<String> = .init()
    var imagesItems: BehaviorRelay<[String]> = .init(value: [])
    var productDetailsSub:PublishSubject<ProductDetails> = .init()
    var selelctedImage:PublishSubject<String> = .init()
    var id:String
    var repo: ProductDetailsRepo
    init(id: String,repo:ProductDetailsRepo) {
        
        self.id = id
        self.repo = repo
    }
    func viewDidLoad() {
        
        getDetails()
    }
    func getForrmstedNumWithCurrency(num:Int)-> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: num)) ?? ""
    }
    private func getDetails() {
        
        isLoading.accept(true)
        repo.getProducDetails(id: id) {[weak self] success, error in
            
            guard let self else{return}
            self.isLoading.accept(false)
            if let success {
                
                self.productDetailsSub.onNext(success)
                self.selelctedImage.onNext(success.images.first ?? "")
                self.imagesItems.accept(success.images)
            }
            if let error {
                
                self.hasErrInTxt.onNext(error)
            }
        }
    }
    func selectedImage(index: Int) {
        
        let imageurl = imagesItems.value[index]
        selelctedImage.onNext(imageurl)
    }
}

