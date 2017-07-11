//
//  Componant.swift
//  TestApp
//
//  Created by hany on 2017. 7. 11..
//  Copyright © 2017년 hany. All rights reserved.
//

import Foundation
import UIKit


protocol ReusableView: class { }
extension ReusableView where Self: UIView {
    
    static var reuseIndentifier: String {
        return String(describing: self)
    }
    
}


protocol NibLoadableView: class { }
extension NibLoadableView where Self: UIView {
    
    static var nibName: String{
        return String(describing: self)
    }
}


extension UITableView {
    func register<T: UITableViewCell>(_ : T.Type) where T: ReusableView, T: NibLoadableView{
        
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIndentifier)
    }
    
    func dequeueResuableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIndentifier, for: indexPath) as? T else{
            fatalError("Could not dequeue cell with identifire!: \(T.reuseIndentifier)")
            
        }
        return cell
    }

}


extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ : T.Type) where T: ReusableView, T: NibLoadableView{
        
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIndentifier)
    }
    
    func dequeueResuableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIndentifier, for: indexPath) as? T else{
            fatalError("Could not dequeue cell with identifire!: \(T.reuseIndentifier)")
            
        }
        return cell
    }
    
}
