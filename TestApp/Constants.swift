//
//  Constant.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 9..
//  Copyright © 2017년 hany. All rights reserved.
//

struct Constants {
    
    static let KEY = "Ejx4tOEJrUzj0J460Snt4dNSCkA0H%2FINuX8Bvec4EMrJJieFwDCHJdL%2BVU%2B6HpuR2nrHrqG8ziZj%2FZ5gwGo0yg%3D%3D"
    
    
    enum ItemTypes : Int { //아래 순서대로 홈에 아이템 타입 배치됨
        case MAIN_BANNER
        case THEMA // 테마별 
        case RECOMMEND
        case BEST_PLACE
        case LOCATION //지역 기반
        
    }
    
    enum DetailItemType : Int { //아래 순서대로 디테일 아이템 타입 배치됨
        case PHOTOS // 사진
        case TITLE // 메인타이틀 부분에 들어갈...
        case SUMMARY // 개요
        case GUIDE // 이용안내
        case LOCATION //지역 기반
        
    }
    
    
    //enum 으로 빼야하지않나?
    struct Path {
        static let LOCATION_FESTIVAL_PATH = "/locationBasedList" //지역 기반
        static let AREA_FESTIVAL_PATH = "/areaBasedList" //위치 기반
        static let SEARCH_FESTIVAL_PATH = "/searchFestival" //검색
        static let FESTIVAL_DETAIL_IMAGE_PATH = "/detailImage" //이미지 상세
    }
}



extension Constants.ItemTypes {
    static func all() -> AnySequence<Constants.ItemTypes> {
        return AnySequence{
            return ItemTypesGenerator()
        }
    }
    
    struct ItemTypesGenerator: IteratorProtocol {
        var currentSection = 0
        
        mutating func next() -> Constants.ItemTypes? {
            guard let item = Constants.ItemTypes(rawValue:currentSection) else {
                return nil
            }
            currentSection += 1
            return item
        }
    }
    
}
