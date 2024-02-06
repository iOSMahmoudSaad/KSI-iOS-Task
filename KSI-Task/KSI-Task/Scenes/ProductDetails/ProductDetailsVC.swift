//
//  ProductDetailsVC.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 06/02/2024.
//

import UIKit
import Kingfisher

class ProductDetailsVC: BaseWireFrame<ProductDetailsVCVieModel> {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var brandLbL: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var imagesColl: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        setupUI()
        bindCollectionView()
        bindBackBtn()
    }
    //MARK: - setup UI
    private func setupUI(){
        
        descriptionLbl.numberOfLines = 0
        imagesColl.registerCell(cellClass: ProductImageCell.self)
        imagesColl.setCollectionViewLayout(UICollectionViewCompositionalLayout(section: productSectionLayout()), animated: true)
        view.backgroundColor = .white
        productImageView.cornerRadius = 15
    }
    fileprivate func productSectionLayout()->NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8 )
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
         let section = NSCollectionLayoutSection(group: group)
         section.interGroupSpacing = 8
         return section
    }

    //MARK: - Bind
    
    override func bind(viewModel: ProductDetailsVCVieModel) {
        viewModel.isLoading.subscribe {[weak self] loading in
            guard let self else{return}
            guard let isLoading = loading.element else{return}
            if isLoading{
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }.disposed(by: disposeBag)
        
        viewModel.hasErrInTxt.subscribe {[weak self] msg in
            guard let self,let msg = msg.element else{return}
            if msg != "" {
                self.createAlert(erroMessage: msg)
            }
        }.disposed(by: disposeBag)
        viewModel.productDetailsSub.subscribe {[weak self] productDetails in
            guard let self,let productDetails = productDetails.element else{return}
            self.productNameLbl.text = productDetails.title
            self.descriptionLbl.text = productDetails.description
            self.priceLbl.text = viewModel.getForrmstedNumWithCurrency(num: productDetails.price)
            self.brandLbL.text = productDetails.brand
        }.disposed(by: disposeBag)
        viewModel.selelctedImage.subscribe {[weak self] imageUrl in
            guard let self ,let imageUrl = imageUrl.element else{return}
            self.productImageView.kf.setImage(with: URL(string: imageUrl))
        }.disposed(by: disposeBag)
       
    }
    func bindCollectionView(){
        
        viewModel.imagesItems.asObservable().bind(to: imagesColl.rx.items(cellIdentifier: ProductImageCell.getIdentifier(),cellType: ProductImageCell.self)){ index,model,cell in
            cell.ConfigureCell(imageUrl: model)
        }.disposed(by: disposeBag)
        imagesColl.rx.itemSelected.subscribe { [weak self] indexPath in
            guard let self,let indexPath = indexPath.element else{return}
            self.viewModel.selectedImage(index: indexPath.item)
        }.disposed(by: disposeBag)
    }
    func bindBackBtn(){
        backBtn.rx.tap.subscribe {[weak self] _ in
            guard let self else{return}
            self.PopToOldPage()
        }.disposed(by: disposeBag)
    }
}
