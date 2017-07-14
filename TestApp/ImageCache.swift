//
//  ImageCache.swift
//  TestApp
//
//  Created by hany on 2017. 7. 14..
//  Copyright © 2017년 hany. All rights reserved.
//

import Foundation
import UIKit


/*
 이미지 캐시 타입 별로 추가하자. 할까? 음-_-;
 */
// 디스크 캐시

class ImageCache {
    
    static let shared = ImageCache()
    
    private let MAX_STORE_COUNT = 200 //캐시에 최대 저장 갯수는 200개로 제한한다.
    private let fileManager = FileManager()
    private let documentsDirectoryURL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    private var cacheFileDir: String {
        get {
            
            let path = NSTemporaryDirectory().appending("cacheDir/")
            if !fileManager.fileExists(atPath: path) {
                try? fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
            }
            
            return path
        }
    }
    
    func store(_ image: UIImage!, forKey key: String!) {
        
        if fileManager.fileExists(atPath: cacheFileDir) {
            if let dataPaths = try? fileManager.contentsOfDirectory(atPath: cacheFileDir), MAX_STORE_COUNT < dataPaths.count {
                //200 개가 넘었다면 앞에서 부터 삭제한다.
                let deletePosition = dataPaths.count - MAX_STORE_COUNT
                for row in 0..<deletePosition {
                    let path = dataPaths[row]
                    
                    do {
                        try fileManager.removeItem(atPath: path )
                        
                    } catch {
                        print("cache remove fail! path [\(path)]")
                        return
                        
                    }
                }
            }
            
            let imageData = UIImagePNGRepresentation(image)
            let imagePath = cacheDataFath(forKey: key)
            let isSuccesed = fileManager.createFile(atPath: imagePath, contents: imageData, attributes: nil)
            
            if let dataPaths = try? fileManager.contentsOfDirectory(atPath: cacheFileDir){
                print("image cache count [\(dataPaths.count)]")
            }
            print("image cache key [\(key)] result : \(isSuccesed)")
        }
    }
    
    func imageFromDiskCache(forKey key: String!) -> UIImage? {
        if let data = fileManager.contents(atPath: cacheDataFath(forKey: key)) {
            let imageData = UIImage.init(data: data)
            return imageData
        }
        
        return nil
    }
    
    
    func removeAllCacheData(){
        do {
            try fileManager.removeItem(atPath: cacheFileDir)
        } catch {
            print("All cache remove fail!")
        }
        
    }
    
    private func cacheDataFath(forKey key: String) -> String {
        return String(format: "%@%@", cacheFileDir ,key.hashValue)
    }
    
    
    
}


