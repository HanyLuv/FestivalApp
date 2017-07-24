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
    
    @IBOutlet weak var sectionTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(BestPlaceItemCell.self)
        
    }
    
    
    override func bindData() {
        sectionTitle.text = items?.sectionTitle
        collectionView.reloadData()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func sizeCell() -> CGSize {
        return  CGSize(width: UIScreen.main.bounds.width, height: 300.0)
    }
    
}


extension BestPlaceCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.festivals?.count ?? 0
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: floor(UIScreen.main.bounds.width / 3) , height: 160)
    }
    


    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueResuableCell(forIndexPath: indexPath) as BestPlaceItemCell
        
        if let items = self.items, let festivals = items.festivals {
            cell.festival = festivals[indexPath.row]
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let items = self.items, let festivals = items.festivals {
            if let imageURL = festivals[indexPath.row].firstimage , let contentId = festivals[indexPath.row].contentid {
                let key = imageURL + String(contentId)
                HttpManager.sharedManager.cancelOperation(withKeyValue: key)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navigationController = self.navigationController else {
            return
        }
        
        let festivalDetatilViewContlloer  = FestivalDetailViewController()
        
        if let items = self.items, let festivals = items.festivals {
            festivalDetatilViewContlloer.festival = festivals[indexPath.row]
        }
        
        navigationController.pushViewController(festivalDetatilViewContlloer, animated: true)
    }
}
