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
        mainTableView.register(ThemaCell.self)
        mainTableView.register(MyPlaceRecommandCell.self)
        
        self.navigationItem.title = "^-^"
        
        for itemType in Constants.ItemTypes.all(){
            let items = Items.init(itemType: itemType)
            if itemType == .RECOMMEND {
                items.sectionTitle = "너에게 딱 맞는 추천"
            } else if itemType == .BEST_PLACE {
                items.sectionTitle = "요즘 핫한 그 곳"
            } else if itemType == .LOCATION {
                items.sectionTitle = "내 주변에서 재미난 곳"
            }
            
            festivals.append(items)
        }
        
        fetchFestival(withPath: Constants.Path.SEARCH_FESTIVAL_PATH, itemType: Constants.ItemTypes.BEST_PLACE)
        fetchFestival(withPath: Constants.Path.SEARCH_FESTIVAL_PATH, itemType: Constants.ItemTypes.RECOMMEND)
        fetchFestival(withPath: Constants.Path.SEARCH_FESTIVAL_PATH, itemType: Constants.ItemTypes.LOCATION)
        
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
                
                DispatchQueue.main.async {
                    let indexSet = IndexSet.init(integer:itemType.rawValue)
                    wself.festivals[itemType.rawValue].festivals = items.festivals
                    wself.tableView.reloadSections(indexSet, with: .fade)
                    
                }
                
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
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let festival = festivals[indexPath.section]
        
        guard let itemType = festival.itemType else {
            return 0.0
        }
        
        switch itemType {
        case .BEST_PLACE, .RECOMMEND:
            return 200.0
            
        case .MAIN_BANNER:
            return 300.0
            
        case .THEMA:
            return 100.0
            
        case .LOCATION:
            //추천 장소에 따라서 크기가 동적으로 변경되어야한다. 하하
            return 300.0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueResuableCell(tableView, cellForRowAt: indexPath)
        return cell
    }
    
    
    private func dequeueResuableCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: BaseTableViewCell
        
        let items = festivals[indexPath.section]
        let itemType = items.itemType!
        
        switch itemType {
        case .BEST_PLACE, .RECOMMEND:
            cell = tableView.dequeueResuableCell(forIndexPath: indexPath) as BestPlaceCell
            cell.items = items
            return cell
            
        case .MAIN_BANNER:
            cell = tableView.dequeueResuableCell(forIndexPath: indexPath) as MainBannerCell
            cell.items = items
            return cell
            
        case .THEMA:
            cell = tableView.dequeueResuableCell(forIndexPath: indexPath) as ThemaCell
            cell.items = items
            return cell
            
        case .LOCATION:
            cell = tableView.dequeueResuableCell(forIndexPath: indexPath) as MyPlaceRecommandCell
            cell.items = items
            return cell
        }
        
    }
    
}
