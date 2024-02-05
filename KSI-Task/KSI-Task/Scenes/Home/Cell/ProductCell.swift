//
//  ProductCell.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import UIKit

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

protocol ProductCellViewModel {
    
    func configurationCeLl(name:String,description:String,price:String,imageUrl:String,isFav:Bool)
}
class ProductCell: UICollectionViewCell,ProductCellViewModel {
    
    @IBOutlet weak var ProductPriceLbl: UILabel!
    @IBOutlet weak var productDescLbl: UILabel!
    @IBOutlet weak var ProductNameLbl: UILabel!
    @IBOutlet weak var faveBtn: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    let disposeBag = DisposeBag()
    var favBtnTapped:(()->())?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        contentView.borderColor = .Gray6
        contentView.borderWidth = 2
        contentView.cornerRadius = 15
        faveBtn.tintColor = .black
        
        faveBtn.rx.tap.subscribe {[weak self] _ in
            
            guard let self else{return}
            self.favBtnTapped?()
        }.disposed(by: disposeBag)
    }
    
    func configurationCeLl(name:String,description:String,price:String,imageUrl:String,isFav:Bool){
        
        ProductNameLbl.text  = name
        productDescLbl.text = description
        ProductPriceLbl.text = price
        productImageView.kf.setImage(with: URL(string: imageUrl))
        faveBtn.tintColor = isFav ? .red : .black
    }
}
