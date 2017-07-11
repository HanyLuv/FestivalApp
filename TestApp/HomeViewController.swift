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

        mainTableView.register(MainBannerCell.self)
        mainTableView.register(BestPlaceCell.self)
        
        self.navigationItem.title = "^-^"

        for itemType in Constants.ItemTypes.all(){
            let items = Items.init(itemType: itemType)
            if itemType == .RECOMMEND {
                items.sectionTitle = "너에게 딱 맞는 추천"
            } else if itemType == .BEST_PLACE {
                items.sectionTitle = "요즘 핫한 그 곳"
            }
            
            festivals.append(items)
        }
        
        fetchFestival(withPath: Constants.Path.SEARCH_FESTIVAL_PATH, itemType: Constants.ItemTypes.BEST_PLACE)
        fetchFestival(withPath: Constants.Path.SEARCH_FESTIVAL_PATH, itemType: Constants.ItemTypes.RECOMMEND)
        
    }
    
    private func fetchFestival(withPath: String, itemType: Constants.ItemTypes){
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
        
        
        HttpManager.sharedManager.fetchFestival(path: withPath, params: params, itemType: itemType, completed: { [weak self] (success, items) in
                                                    
            if(success) {
                print("hany tag success \(success.hashValue)" )
                guard let wself = self, let items = items, let itemType = items.itemType else { return }
                wself.festivals[itemType.rawValue].festivals = items.festivals
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
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         //각 셀마다 정해진 높이가 있으며 이를 반영해야한다..
        return 300
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < festivals.count {
            
            let items = festivals[indexPath.row]
            let itemType = items.itemType!
            
            
            var cell = BaseTableViewCell()
                cell.items = items
            
            switch itemType {
                case .BEST_PLACE, .RECOMMEND:
                    cell = tableView.dequeueResuableCell(forIndexPath: indexPath) as BestPlaceCell
                    cell.items = items
                case .MAIN_BANNER:
                    cell = tableView.dequeueResuableCell(forIndexPath: indexPath) as MainBannerCell
                
            }
            
            return cell
        }
        
        
        
        
        return UITableViewCell()
        
    }
    
    
}
