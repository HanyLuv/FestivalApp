//
//  TabBarViewController.swift
//  TestApp
//
//  Created by hany on 2017. 7. 3..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var params = [String:String]()
        params["contentTypeId"] = "39"
        params["mapX"] = "126.981611"
        params["mapY"] = "37.568477"
        params["radius"] = "500"
        params["pageNo"] = "1"
        params["numOfRows"] = "5"
        params["listYN"] = "Y"
        params["arrange"] = "A"
        params["MobileOS"] = "IOS"
        params["MobileApp"] = "TestApp"
        params["_type"] = "json"
        
    
        HttpManager.sharedManager.fetchFestival(params: params)
        
        
        
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
