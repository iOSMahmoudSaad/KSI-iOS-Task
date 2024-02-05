//
//  Collectionview + Extension.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func registerCell<Cell: UICollectionViewCell>(cellClass: Cell.Type) {
        
        
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: Cell.self))
    }
    
    
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell {
        
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            
            fatalError("Error in cell")
        }
        return cell
    }
    
    func registerHeaderFooter<Cell: UICollectionReusableView>(cellClass: Cell.Type, kind: String) {
        
       
        self.register(UINib(nibName: String(describing: Cell.self), bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: Cell.self))
    }
    
 
    
    func dequeueHeaderFooter<Cell: UICollectionReusableView>(kind: String, indexPath:IndexPath) -> Cell {
        
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? Cell else {
            
            fatalError("Error in cell")
        }
        return cell
    }

    
}
