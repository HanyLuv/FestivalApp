//
//  DetailImage.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 23..
//  Copyright © 2017년 hany. All rights reserved.
//

import Foundation
import ObjectMapper

class Image: Mappable {
    /*
     <item>
     <contentid>1953272</contentid>
     <originimgurl>
     http://tong.visitkorea.or.kr/cms/resource/38/1953238_image2_1.JPG
     </originimgurl>
     <serialnum>1953238_1</serialnum>
     <smallimageurl>
     http://tong.visitkorea.or.kr/cms/resource/38/1953238_image2_1.JPG
     </smallimageurl>
     </item>
     
     */
    
    var contentid: Int?
    var originimgurl: String?
    var serialnum: String?
    var smallimageurl: String?
    
    var key: String? {
        get {
            if let contentId = self.contentid, let imageURL = self.originimgurl {
                return String.init(format: "%@%@%@", imageURL,"/contentId/",String(contentId))
            }
            
            return nil
        }
    }
    
    required init(map: Map) {
    }
    
    func mapping(map: Map) {
        contentid    <- map["contentid"]
        originimgurl    <- map["originimgurl"]
        smallimageurl    <- map["smallimageurl"]
        serialnum    <- map["serialnum"]

    }
    

}
