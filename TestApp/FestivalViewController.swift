//
//  FestivalViewController.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 6..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit

class FestivalViewController: UIViewController {


    @IBOutlet weak var collectionView: UICollectionView!

    fileprivate let festivalCellIdentifier = "festivalCellIdentifier"
    fileprivate var festivals :[Festival]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "FestivalCell", bundle: nil), forCellWithReuseIdentifier: festivalCellIdentifier)
        
        
        var params = [String:String]()
        params["contentTypeId"] = "39"
        params["mapX"] = "126.981611"
        params["mapY"] = "37.568477"
        params["radius"] = "500"
        params["pageNo"] = "1"
        params["numOfRows"] = "30"
        params["listYN"] = "Y"
        params["arrange"] = "A"
        params["MobileOS"] = "IOS"
        params["MobileApp"] = "TestApp"
        params["_type"] = "json"
        
        
        HttpManager.sharedManager.fetchFestival(params: params, completed: {
            [weak self] (success, items) -> Void in
            guard let wself = self else { return }
            
            if let items = items {
                DispatchQueue.main.async {
                    wself.festivals = items.festivals
                    wself.collectionView.reloadData()
                }
            }
        
            
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


//MARK : UICollectionViewDelegate
extension FestivalViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 50)
    }
}

//MARK : UICollectionViewDelegateFlowLayout
extension FestivalViewController: UICollectionViewDelegateFlowLayout {
    
}

//MARK : UICollectionViewDataSource
extension FestivalViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return festivals?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: festivalCellIdentifier, for: indexPath) as! FestivalCell
        
        if let festivals = festivals {
            let festival = festivals[indexPath.row]
            cell.festival = festival
        }
        
        return cell
    }
    
}
