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
    //튜플로 데이터를 저장합시다 ㅇㅁㅇ
    fileprivate var details: [(Constants.DetailItemType, Any?)] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.navigationController?.title = "행사 상세 화면"
        
        self.tableView.register(ImagePagerCellTableViewCell.self)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        details.append((.PHOTOS, nil))
        
        var params = [String:String]()
        if let id = festival?.contentid {
            params["contentId"] = String.init(id)
        }else{
            params["contentId"] = "1953272"
        }
        
        HttpManager.sharedManager.fecthFestivalDetailImages(params: params, itemType: .PHOTOS) {[weak self] (success, images, itemType) in
            
            if(success) {
                //                details.in
                DispatchQueue.main.async {[weak self]() -> Void in
                    guard let wself = self else { return }
                    
                    let indexSet = IndexSet.init(integer: itemType.rawValue)
                    wself.details[itemType.rawValue].1 = images
                    
                    print(String.init(describing: wself.details[itemType.rawValue].1))
                    wself.tableView.reloadSections(indexSet, with: .fade)
                    
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

extension FestivalDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return details.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueResuableCell(forIndexPath: indexPath) as ImagePagerCellTableViewCell
        if let images = details[indexPath.row].1 as? [Image] {
            cell.images = images
        }
        return cell
    }
    
    
}
