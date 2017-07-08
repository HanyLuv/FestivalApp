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
    func onSuccess(responseJson: [Festival])
    //    func onFail(error: RequestError)
}

enum HttpMethod: String{
    case POST = "POST"
    case GET = "GET"
}

enum Path: String{
    case LOCATION = "locationBasedList?"
    case AREA = "areaBasedList?"
}

class HttpManager: NSObject {
    
    private let MAX_OPERATION_COUNT: Int = 1
    fileprivate var opQueue: OperationQueue
    
    private let KEY = "Ejx4tOEJrUzj0J460Snt4dNSCkA0H%2FINuX8Bvec4EMrJJieFwDCHJdL%2BVU%2B6HpuR2nrHrqG8ziZj%2FZ5gwGo0yg%3D%3D"
    
    private let BASE_URL = "https://api.visitkorea.or.kr/openapi/service/rest/KorService/"
    private let LOCATION_FESTIVAL_PATH = "locationBasedList?" //지역 기반
    private let AREA_FESTIVAL_PATH = "areaBasedList?" //위치 기반
    
    
    let session: URLSession = {
        let headers: [String:String] = ["User-Agent": "MATT/1.0 (memeBox/4.1.5.320; iPhone OS/10.1; ko_KR; iPhone/x86_64; 750,1334)",
                                    "Content-Type":"application/json"]
        
        let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 5
            config.httpAdditionalHeaders = headers
        
        return URLSession(configuration: config)
    }()
    
    static var sharedManager: HttpManager {
        struct Static {
            static let instance: HttpManager = HttpManager()
        }
        return Static.instance
    }
    
    private override init(){
        opQueue = OperationQueue()
        //최대 요청 갯수....
        opQueue.maxConcurrentOperationCount = MAX_OPERATION_COUNT
    }
    
    internal func fetchFestival(params: [String:String], completed callback: @escaping (_ success: Bool, _ items: Items?) -> Void) {
        var params = params
        params["_type"] = "json"
        
        var urlStr = BASE_URL+LOCATION_FESTIVAL_PATH + "ServiceKey" + "=" + KEY + "&"
        
        var paramsStr: String = ""
        for (key,value) in params{
            paramsStr += key+"="+value+"&"
        }
        
        urlStr += paramsStr
        
        let url = URL(string: urlStr)!
        
        let task = session.dataTask(with: url) { (data, response, error) -> Void in
            
            if let httpStatus = response as? HTTPURLResponse {           // check for http errors 200 성공임.
                print("response \(httpStatus.statusCode)")
            }
            
            if let strData = String(data: data!, encoding: .utf8){
                let json = JSON(parseJSON: strData)
                let jsonItems = json["response"]["body"]["items"]
                
                if let strItems = jsonItems.rawString(), let items = Items(JSONString:strItems) {
                    callback(true, items)
                    
                } else {
                    callback(false, nil)
                }
                
                
            }
        }
        
        task.resume()
    }
}
