//
//  Header.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 3..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit
import ObjectMapper

class Header: Mappable{
    /*
     "resultCode": "0000",
     "resultMsg": "OK"
     */
    
    var resultCode: String?
    var resultMsg: String?
    
    required init(map: Map) {
    }
    
    func mapping(map: Map) {
        resultCode    <- map["resultCode"]
        resultMsg         <- map["resultMsg"]
    }
    
    
    
    
}
