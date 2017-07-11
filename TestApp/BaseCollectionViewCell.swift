//
//  BaseCollectionViewCell.swift
//  TestApp
//
//  Created by hany on 2017. 7. 11..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, NibLoadableView, ReusableView {
    
    var festival: Festival?{
        didSet{
            bindData()
        }
    }

    func bindData(){
        
    }
}
