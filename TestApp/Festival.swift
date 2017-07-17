//
//  Festival.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 3..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit
import ObjectMapper

class Festival: Mappable {
    
    
    /*
     "addr1": "서울특별시 종로구 종로8길 16",
     "addr2": "(관철동)",
     "areacode": 1,
     "cat1": "A05",
     "cat2": "A0502",
     "cat3": "A05020100",
     "contentid": 1953272,
     "contenttypeid": 39,
     "createdtime": 20141001104426,
     "dist": 221,
     "firstimage": "http://tong.visitkorea.or.kr/cms/resource/46/1953246_image2_1.JPG",
     "firstimage2": "http://tong.visitkorea.or.kr/cms/resource/46/1953246_image2_1.JPG",
     "mapx": "126.9838371210", // 어떤건 소수.. 어떤건 문자 인건가 -_-;; 확인해봐야겟다..
     "mapy": 37.5693679015,
     "mlevel": 6,
     "modifiedtime": 20160622113814,
     "readcount": 3342,
     "sigungucode": 23,
     "tel": "02-737-4987",
     "title": "가마목"
     
     */
    
    
    var addr1: String?
    var addr2: String?
    var areacode: Int?
    var cat1: String?
    var cat2: String?
    var cat3: String?
    var contentid: Int?
    var contenttypeid: Int?
    var createdtime: Int?
    var dist: Int?
    var firstimage: String?
    var firstimage2: String?
    var mapx: Float?
    var mapy: Float?
    var mlevel: Int?
    var modifiedtime: Int?
    var readcount:Int? //조회수
    var sigungucode: Int?
    var tel: String?
    var title: String?
    
    var key: String? {
        get {
            if let contentId = self.contentid, let imageURL = self.firstimage {
                return String.init(format: "%@%@%@", imageURL,"/contentId/",String(contentId))
            }
            
            return nil
        }
    }
    
    required init(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        addr1           <- map["addr1"]
        addr2           <- map["addr2"]
        areacode        <- map["areacode"]
        cat1            <- map["cat1"]
        cat2            <- map["cat2"]
        cat3            <- map["cat3"]
        contentid     <- map["contentid"]
        contenttypeid    <- map["contenttypeid"]
        createdtime    <- map["createdtime"]
        dist    <- map["dist"]
        firstimage    <- map["firstimage"]
        firstimage2    <- map["firstimage2"]
        mapx    <- map["mapx"]
        mapy    <- map["mapy"]
        mlevel    <- map["mlevel"]
        modifiedtime    <- map["modifiedtime"]
        readcount    <- map["readcount"]
        sigungucode    <- map["sigungucode"]
        tel    <- map["tel"]
        title    <- map["title"]
        
    }
    
}
