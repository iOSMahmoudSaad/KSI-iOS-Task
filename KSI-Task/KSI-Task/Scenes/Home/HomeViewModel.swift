//
//  HomeViewModel.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeVCViewModelOutput{
    
    var productItems:BehaviorRelay<[Product]>{get set}
    var productCount:BehaviorRelay<String>{get set}
    func viewDidLoad()
    func getForrmstedNumWithCurrency(num:Int)-> String
    var navigateToDetails:PublishSubject<String>{get set}
}

protocol HomeVCViewModelInput {
    
    func productItemSelected(index:Int)
    func itemFavBtnTapped(id:String)
    var searchText:BehaviorRelay<String>{get set}
}
class HomeVCViewModel:ViewModel,HomeVCViewModelInput,HomeVCViewModelOutput {
    
    var hasErrInTxt: PublishSubject<String> = .init()
    var isLoading: BehaviorRelay<Bool> = .init(value:false)
    var productItems:BehaviorRelay<[Product]> = .init(value: [])
    var productCount:BehaviorRelay<String> = .init(value: "0 products found")
    var navigateToDetails:PublishSubject<String> = .init()
    var searchText:BehaviorRelay<String> = .init(value: "")
    
    private var getProductListUsecase: GetProductListUsecase
    private var productItemFavUsecase: FavouriteProductItemUseCase
    private let disposeBag = DisposeBag()
    
    init(getProductListUsecase: GetProductListUsecase,productItemFavUsecase:FavouriteProductItemUseCase) {
        
        self.getProductListUsecase = getProductListUsecase
        self.productItemFavUsecase = productItemFavUsecase
        searchText
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] search in
                guard let self = self else { return }
                let allProducts = self.productItems.value
                
                if search.isEmpty {
                    
                     
                    self.productItems.accept(allProducts)
                    self.productCount.accept("\(allProducts.count) products found")
                } else {
                  
                    let filteredProducts = allProducts.filter { $0.name.localizedCaseInsensitiveContains(search) }
                    self.productItems.accept(filteredProducts)
                    self.productCount.accept("\(filteredProducts.count) products found")
                }
            })
            .disposed(by: disposeBag)
    }
    func viewDidLoad() {
        
        getProductItems()
    }
    private func getProductItems(){
        
        isLoading.accept(true)
        getProductListUsecase.excute {[weak self] success, error in
            guard let self else{return}
            self.isLoading.accept(false)
            if let success {
                self.productItems.accept(success.products)
                self.productCount.accept("\(success.products.count) Product found")
            }
            if let error {
                self.hasErrInTxt.onNext(error)
            }
        }
    }
    func getForrmstedNumWithCurrency(num:Int)-> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter.string(from: NSNumber(value: num)) ?? ""
    }
    func productItemSelected(index:Int) {
        navigateToDetails.onNext(productItems.value[index].id)
    }
    
    func itemFavBtnTapped(id:String) {
        
        isLoading.accept(true)
        productItemFavUsecase.excute(id: id) {[weak self] success, error in
            
            guard let self else{return}
            self.isLoading.accept(false)
            if let success {
                
                self.productItems.accept(success.products)
                self.productCount.accept("\(success.products.count) Product found")
            }
            
            if let error {
                self.hasErrInTxt.onNext(error)
            }
        }
    }
}

