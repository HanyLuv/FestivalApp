//
//  HttpManager.swift
//  TestApp
//
//  Created by hany on 2017. 7. 3..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol HttpRequestResponse {
    func onSuccess(responseJson: JSON)
//    func onFail(error: RequestError)
}

class HttpManager: NSObject {
    
    fileprivate var opQueue: OperationQueue
    
    static var sharedManager: FestivalManager {
        struct Static {
            static let instance: FestivalManager = FestivalManager()
        }
        return Static.instance
    }
    
    private override init(){
        opQueue = OperationQueue()
        opQueue.maxConcurrentOperationCount = 1 //최대 요청 갯수....
    }

}
