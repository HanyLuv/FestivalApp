//
//  Body.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 3..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit
import ObjectMapper

class Body: Mappable {
    
    var items: Items?
    var numOfRows: Int?
    var pageNo: Int?
    var totalCount: Int?
    
    required init(map: Map) {
    }
    
    
    func mapping(map: Map) {
        items    <- map["items"]
        numOfRows    <- map["numOfRows"]
        pageNo    <- map["pageNo"]
        totalCount    <- map["totalCount"]
        
    }
}
