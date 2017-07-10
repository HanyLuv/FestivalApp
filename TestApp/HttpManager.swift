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

class HttpManager: NSObject {
    private let baseURL = "https://api.visitkorea.or.kr/openapi/service/rest/KorService"
    
    
    private let MAX_OPERATION_COUNT: Int = 1
    fileprivate var opQueue: OperationQueue
    
    static var sharedManager: HttpManager {
        struct Static {
            static let instance: HttpManager = HttpManager()
        }
        return Static.instance
    }
    
    fileprivate let session: URLSession = {
        let headers: [String:String] = ["User-Agent": "MATT/1.0 (memeBox/4.1.5.320; iPhone OS/10.1; ko_KR; iPhone/x86_64; 750,1334)",
                                    "Content-Type":"application/json"]
        
        let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 5
            config.httpAdditionalHeaders = headers
        
        return URLSession(configuration: config)
    }()
    
    private override init(){
        opQueue = OperationQueue()
        opQueue.maxConcurrentOperationCount = MAX_OPERATION_COUNT
    }
    
    internal func fetchFestival(params: [String:String], completed callback: @escaping (_ success: Bool, _ items: Items?) -> Void) {
        
        let urlRequest = createGetRequest(path: Constants.Path.LOCATION_FESTIVAL_PATH, params: params)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
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
        
        opQueue.addOperation(HttpOperation.init(task: task))
    }
    
    
    private func createGetRequest(path: String, params: [String: String]) -> URLRequest {
        var params = params
        params["_type"] = "json"
        
        var paramsStr: String = "?"
        for (key,value) in params{
            paramsStr += key+"="+value+"&"
        }
        
        let url = URL.init(string: baseURL + path + paramsStr)!
        print("url [ \( baseURL + paramsStr) ]")
        
        var requset = URLRequest.init(url: url)
        requset.httpMethod = "GET"
        
        return requset
    }
    
    
    internal func cancelAll(){
        for operation in opQueue.operations {
            operation.cancel()
        }
    }
    
    
}





fileprivate class HttpOperation: Operation {
    private let task: URLSessionTask
    
    init(task: URLSessionTask) {
        self.task = task
    }
    
    override open func main(){
        super.main()
        task.resume()
    }
    
    override func cancel() {
        super.cancel()
        task.cancel()
        
        print("hany tag cancel status : \(task.state.rawValue )" )

    }
    
}
