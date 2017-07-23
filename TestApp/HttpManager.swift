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
    
    internal func fetchSearchFestival(params: [String:String], completed callback: @escaping (_ success: Bool, _ items: Items?) -> Void) {
        
        let urlRequest = createGetRequest(path: Constants.Path.SEARCH_FESTIVAL_PATH, params: params)
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
    
    
    
    internal func fetchFestival(path: String ,params: [String:String], itemType : Constants.ItemTypes,
                                completed callback: @escaping (_ success: Bool, _ items: Items?) -> Void) {
        
        let urlRequest = createGetRequest(path: path, params: params)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpStatus = response as? HTTPURLResponse {           // check for http errors 200 성공임.
                print("response \(httpStatus.statusCode)")
            }
            
            // 가지고온 데이터에서 resultCode에 따른 오류 처리해야함... 아래는 시리얼키 안넣었을때임.
            //"{\"response\":{\"header\":{\"responseTime\":\"2017-07-11T11:39:33.534+09:00\",\"resultCode\":10,\"resultMsg\":\"INVALID REQUEST PARAMETER ERROR.\"}}}"
            
            
            if let strData = String(data: data!, encoding: .utf8){
                let json = JSON(parseJSON: strData)
                let jsonItems = json["response"]["body"]["items"]
                
                if let strItems = jsonItems.rawString(), let items = Items(JSONString:strItems) {
                    items.itemType = itemType
                    callback(true, items)
                    
                } else {
                    callback(false, nil)
                }
                
                
            }
        }
        
        opQueue.addOperation(HttpOperation.init(task: task))
    }
    
    internal func fetchFestivalPhotoImage(withFestival festival: Festival, callback: @escaping ((_ image: UIImage?, _ key: String) -> Void)){
        //postion을 붙인 이유는 url로 operation의 key값을 저장하는데 중복되는 url일경우 잘못된 row의 요청을 취소할지도 모르기때문이다.
        //유니크 키 생성 좀더 생각해봐야 할듯 -_-ㅠ
        guard let key = festival.key, let strURL = festival.firstimage else {
            return
        }

        let imageURL = URL.init(string: strURL)!
        let task = session.dataTask(with: imageURL) { (data, response, error) -> Void in
            
            if let error = error {
                print("\(error)")
                return
            }
            
            if let data = data {
                let image = UIImage(data: data)
                callback(image, key)
                
            }
        }
        
        let operation = HttpOperation.init(task: task)
        operation.name = key
        opQueue.addOperation(operation)
    }
    
    //이미지 가져오는 func. 위의 함수와 합쳐주자.

    internal func fetchImage(withImageStringURL strURL: String, callback: @escaping ((_ image: UIImage?, _ key: String) -> Void)){
    
        let imageURL = URL.init(string: strURL)!
        let task = session.dataTask(with: imageURL) { (data, response, error) -> Void in
            
            if let error = error {
                print("\(error)")
                return
            }
            
            if let data = data {
                let image = UIImage(data: data)
                callback(image, "tamp")
                
            }
        }
        
        let operation = HttpOperation.init(task: task)
        operation.name = "tamp"
        opQueue.addOperation(operation)
        
    }
    
    
    private func createGetRequest(path: String, params: [String: String]) -> URLRequest {
        var params = params
        params["ServiceKey"] = Constants.KEY
        params["_type"] = "json"
        params["MobileOS"] = "IOS" //와 세상에 iOS로하면 파라미터 에러가--;
        params["MobileApp"] = "TestApp"
        
        var paramsStr: String = "?"
        for (key,value) in params{
            paramsStr += key+"="+value+"&"
        }
        
        let url = URL.init(string: baseURL + path + paramsStr)!
        print("url [ \( baseURL + path + paramsStr) ]")
        
        var requset = URLRequest.init(url: url)
        requset.httpMethod = "GET"
        
        return requset
    }
    
    
    internal func cancelAll(){
        for operation in opQueue.operations {
            operation.cancel()
        }
    }
    
    internal func cancelOperation(withKeyValue name: String) {
        for operation in opQueue.operations {
            if operation.name == name {
                operation.cancel()
            }
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
