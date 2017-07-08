//
//  Items.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 3..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit
import ObjectMapper

class Items: Mappable {
    
    var festivals: [Festival]?
    
    required init(map: Map) {
    }
    
    func mapping(map: Map) {
        festivals    <- map["item"]
    }

}
