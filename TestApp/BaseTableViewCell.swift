//
//  BaseTableViewCell.swift
//  TestApp
//
//  Created by hany on 2017. 7. 11..
//  Copyright © 2017년 hany. All rights reserved.
//
import UIKit

class BaseTableViewCell: UITableViewCell, NibLoadableView, ReusableView {
    var navigationController: UINavigationController?
    
    var items: Items?{
        didSet{
            bindData()
        }
    }
    
    func bindData(){
        
    }
    
    func sizeCell() -> CGSize {
        return CGSize()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
