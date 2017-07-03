//
//  HttpManager.swift
//  TestApp
//
//  Created by hany on 2017. 7. 3..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit
import Alamofire

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
        let config = URLSessionConfiguration.default
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
    
    
    //   let headers = ["User-Agent": "MATT/1.0 (memeBox/4.1.5.320; iPhone OS/10.1; ko_KR; iPhone/x86_64; 750,1334)"]
    
    internal func fetchFestival(params: [String:Any]) {
        var params = params
        params["_type"] = "json"

        
        let headers: HTTPHeaders = ["User-Agent": "MATT/1.0 (memeBox/4.1.5.320; iPhone OS/10.1; ko_KR; iPhone/x86_64; 750,1334)",
                                    "Content-Type":"application/json"]
        
        let urlStr = BASE_URL+LOCATION_FESTIVAL_PATH + "ServiceKey" + "=" + KEY
        
        Alamofire.request(urlStr, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response)  in
            if let jsonValue = response.result.value {
                print("JSON : \(jsonValue)")
            }
        }
        
        
        //        let task = session.dataTask(with: urlRequest) { (data, response, error) -> Void in
        //
        //            if let httpStatus = response as? HTTPURLResponse {           // check for http errors
        //                print("response \(httpStatus.statusCode)")
        //            }
        //
        //            if let strData = String(data: data!, encoding: .utf8){
        //                print(" result \(strData)")
        //            }}
        //        
        //        task.resume()
    }
}
