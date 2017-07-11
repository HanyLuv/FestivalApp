//
//  BestPlaceCell.swift
//  TestApp
//
//  Created by hany on 2017. 7. 10..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit

class BestPlaceCell: BaseTableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BestPlaceItemCell.self)
        
    }
    
    
    override func bindData() {
        
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


extension BestPlaceCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.festivals?.count ?? 0
    }
    


    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueResuableCell(forIndexPath: indexPath) as BestPlaceItemCell
        
        if let items = self.items, let festivals = items.festivals {
            cell.festival = festivals[indexPath.row]
        }
    
        return cell
    }
    
}
