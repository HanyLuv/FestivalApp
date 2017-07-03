//
//  Response.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 3..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit
import ObjectMapper

class Response: Mappable {
    
    var header: Header?
    var body: Body?
    
    required init(map: Map) {
    }
    
    func mapping(map: Map) {
        header    <- map["header"]
        body    <- map["body"]
    }
    

}
