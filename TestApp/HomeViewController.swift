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

    fileprivate var festivals :[Items]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(UINib.init(nibName: "MainBannerCell", bundle: nil), forCellReuseIdentifier: MainBannerCell.identifier)
        mainTableView.register(UINib.init(nibName: "ThemaCell", bundle: nil), forCellReuseIdentifier: ThemaCell.identifier)
//        mainTableView.register(UINib.init(nibName: "BestPlaceCell", bundle: nil), forCellReuseIdentifier: BestPlaceCell.identifier)
        mainTableView.register(UINib.init(nibName: "LocationRecommendCell", bundle: nil), forCellReuseIdentifier: LocationRecommendCell.identifier)
        mainTableView.register(UINib.init(nibName: "PersonalRecommendCell", bundle: nil), forCellReuseIdentifier: PersonalRecommendCell.identifier)

        
        fetchFestival()
        
    }
    
    private func fetchFestival(){
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
        
        HttpManager.sharedManager.fetchFestival(params: params, completed: { (success, items) in

            if(success){
                print("hany tag success \(success.hashValue)" )
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
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
