//
//  HomeVC.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

 import UIKit
 import RxSwift
 import RxCocoa

class HomeVC: BaseWireFrame<HomeVCViewModel> {
    
    
    @IBOutlet weak var searchView: UIView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var productCountLbl: UILabel!
    
    @IBOutlet weak var productColl: UICollectionView!
    
    internal let disposeBag1 = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindCollectionView()
        viewModel.viewDidLoad()
        bindSearchText()
    }
   
    //MARK: - setup UI
    
    private func setupUI(){
        searchTextField.setPlaceHolderColor(.DarkGray,Fonts.regular(name: FontName.Montserrat.rawValue, size: FontSize.fontMedium))
        searchView.layer.cornerRadius = 10
        productColl.registerCell(cellClass: ProductCell.self)
        productColl.setCollectionViewLayout(UICollectionViewCompositionalLayout(section: productSectionLayout()), animated: true)
    }
    fileprivate func productSectionLayout()->NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(215))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item,item])
         let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
         return section
    }
    //MARK: - Bind
    override func bind(viewModel: HomeVCViewModel) {
        viewModel.isLoading.subscribe {[weak self] loading in
            guard let self else{return}
            guard let isLoading = loading.element else{return}
            if isLoading{
                self.showIndicator(withTitle: "", and: "")
            }else{
                self.hideIndicator()
            }
        }.disposed(by: disposeBag)
        
        viewModel.hasErrInTxt.subscribe {[weak self] msg in
            guard let self,let msg = msg.element else{return}
            if msg != "" {
                self.createAlert(erroMessage: msg)
            }
        }.disposed(by: disposeBag)
        
        viewModel.navigateToDetails.subscribe {[weak self] id in
            
            guard let self ,let id = id.element else{return}
            self.coordinator.main.navigate(to: .productDetails(id: id))
        }.disposed(by: disposeBag)
        
        viewModel.productCount.subscribe {[weak self] count in
            guard let self ,let count = count.element else{return}
            self.productCountLbl.text = count
        }.disposed(by: disposeBag)
    }
    func bindSearchText() {
        searchTextField.rx.text
                   .orEmpty
                   .bind(to: viewModel.searchText)
                   .disposed(by: disposeBag)
       
    }
    
    func bindCollectionView(){
        
        viewModel.productItems.asObservable().bind(to: productColl.rx.items(cellIdentifier: ProductCell.getIdentifier(),cellType: ProductCell.self)){[weak self] index,model,cell in
            guard let self else{return}
            cell.configurationCeLl(name: model.name, description: model.description, price: self.viewModel.getForrmstedNumWithCurrency(num: model.price), imageUrl: model.thumbnail, isFav: model.isFav)
            cell.favBtnTapped = {
                self.viewModel.itemFavBtnTapped(id:model.id)
            }
        }.disposed(by: disposeBag)
        productColl.rx.itemSelected.subscribe { [weak self] indexPath in
            guard let self,let indexPath = indexPath.element else{return}
            self.viewModel.productItemSelected(index: indexPath.item)
        }.disposed(by: disposeBag)
    }
}


