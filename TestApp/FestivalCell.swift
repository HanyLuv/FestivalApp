//
//  FestivalCell.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 6..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit

class FestivalCell: UICollectionViewCell {

    var festival: Festival?{
        didSet{
            bindData()
        }
    }
    @IBOutlet weak var titleLabelView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func bindData(){
        
        titleLabelView.text = festival!.title
    }

}
