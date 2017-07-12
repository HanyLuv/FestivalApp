//
//  MyPlaceRecommendItemView.swift
//  TestApp
//
//  Created by hany on 2017. 7. 12..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit

class MyPlaceRecommendItemView: UIView {
    
    static let height = 100
    
    @IBOutlet weak var titleLabel: UILabel!
    var fastival: Festival?{
        didSet{
            bindData()
        }
    }
    
    private func bindData(){
        
    }
    
    
    
    
}
