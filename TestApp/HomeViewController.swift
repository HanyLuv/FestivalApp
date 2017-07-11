//
//  HomViewController.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 9..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {
    
    @IBOutlet var mainTableView: UITableView!
    
    fileprivate var festivals :[Items] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mainTableView.delegate = self
        mainTableView.dataSource = self

        mainTableView.register(BaseTableViewCell.self)
        mainTableView.register(BestPlaceCell.self)
        
        

        for itemType in Constants.ItemTypes.all(){
            festivals.append(Items.init(itemType: itemType))
        }
        
        fetchFestival()
        
    }
    
    private func fetchFestival(){
        var params = [String:String]()
        /* 지역 기반.
         params["contentTypeId"] = "39"
         params["mapX"] = "126.981611"
         params["mapY"] = "37.568477"
         params["radius"] = "500"
         params["pageNo"] = "1"
         params["numOfRows"] = "30"
         params["listYN"] = "Y"
         params["arrange"] = "A"
         */
        
        params["eventStartDate"] = "20130101"
        params["arrange"] = "B" //조회순
        params["pageNo"] = "1"
        params["numOfRows"] = "10"
        
        
        HttpManager.sharedManager.fetchFestival(path: Constants.Path.SEARCH_FESTIVAL_PATH, params: params, itemType: Constants.ItemTypes.BEST_PLACE,
                                                completed: { [weak self] (success, items) in
                                                    
            if(success) {
                print("hany tag success \(success.hashValue)" )
                guard let wself = self, let items = items, let itemType = items.itemType else { return }
                wself.festivals[itemType.rawValue] = items
                wself.mainTableView.reloadData()
            }
                                                    
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return festivals.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return festivals[section].festivals?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = BaseTableViewCell()
        
        if indexPath.row < festivals.count {
        
            let items = festivals[indexPath.row]
            let itemType = items.itemType!
            
            cell = tableView.dequeueResuableCell(forIndexPath: indexPath) as BestPlaceCell
            cell.items = items
            
            switch itemType {
                
            case .BEST_PLACE:
                cell = tableView.dequeueResuableCell(forIndexPath: indexPath) as BaseTableViewCell
                cell.items = items

            default:
                return cell
            }
        }
        
        
        
        
        return UITableViewCell()
        
    }
    
    
}
