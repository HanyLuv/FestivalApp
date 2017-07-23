//
//  FestivalDetailViewController.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 23..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit

class FestivalDetailViewController: UIViewController {
    
    var festival: Festival?
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = "행사 상세 화면"
        
        //        if let festival = self.festival {
        var params = [String:String]()
        params["contentId"] = "1953272"
        HttpManager.sharedManager.fecthFestivalDetailImages(params: params) {[weak self] (success, detileImages) in
            
            if(success) {
                print("hany tag success \(success.hashValue)" )
//                guard let wself = self, let items = items, let itemType = items.itemType else { return }
                
                DispatchQueue.main.async {
//                    let indexSet = IndexSet.init(integer:itemType.rawValue)
//                    wself.festivals[itemType.rawValue].festivals = items.festivals
//                    wself.tableView.reloadSections(indexSet, with: .fade)
                    
                }
                
            }
        }
        //        }
        // Do any additional setup after loading the view.
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
