//
//  ThemaCell.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 9..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit

class ThemaCell: BaseTableViewCell {
    static let identifier =  "ThemaCellIdentifire"
    
    @IBOutlet weak var firstThemaLabel: UILabel!
    @IBOutlet weak var secondThemaLabel: UILabel!
    @IBOutlet weak var thirdThemaLabel: UILabel!
    @IBOutlet weak var fourthThemaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func sizeCell() -> CGSize {
        return  CGSize(width: UIScreen.main.bounds.width, height: 100.0)
    }
}
