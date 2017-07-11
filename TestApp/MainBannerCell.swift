//
//  MainBannerCell.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 9..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit

class MainBannerCell: BaseTableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func bindData() {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    class func sizeCell() -> CGSize {
//        return  CGSize(width: ().width, height: 112.0 + 8.0)
//    }
    
    override class func sizeCell() -> CGSize {
        return  CGSize(width: UIScreen.main.bounds.width, height: 300.0)
    }
    
}
