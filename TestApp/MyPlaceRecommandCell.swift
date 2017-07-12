//
//  MyPlaceRecommandCell.swift
//  TestApp
//
//  Created by hany on 2017. 7. 12..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit

class MyPlaceRecommandCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func bindData() {
        guard let items = self.items else { return }
        titleLabel.text = items.sectionTitle
 
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func sizeCell() -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.width, height: 300.0)
    }
    
}
