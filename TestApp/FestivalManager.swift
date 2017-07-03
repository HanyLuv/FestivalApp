//
//  HttpRequset.swift
//  TestApp
//
//  Created by hany on 2017. 7. 3..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit

class FestivalManager: HttpManager {

    
    private let baseURL = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival" //날짜 기반
    private let baseLocationURL = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList" //지역 기반
    private let key = "Ejx4tOEJrUzj0J460Snt4dNSCkA0H%2FINuX8Bvec4EMrJJieFwDCHJdL%2BVU%2B6HpuR2nrHrqG8ziZj%2FZ5gwGo0yg%3D%3D"
    
    
    func loadFestivals() -> String {
        
//        NSURLConnection.sendSynchronousRequest(<#T##request: URLRequest##URLRequest#>, returning: <#T##AutoreleasingUnsafeMutablePointer<URLResponse?>?#>)
        return ""
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
