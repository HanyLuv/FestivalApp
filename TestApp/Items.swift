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
    
    var itemType: Constants.ItemTypes?
    var festivals: [Festival]?
    
    init(itemType: Constants.ItemTypes) {
        self.itemType = itemType
    }
    
    required init(map: Map) {
    }
    
    func mapping(map: Map) {
        festivals    <- map["item"]
    }

}
