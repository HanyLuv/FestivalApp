//
//  Created by 김환희 on 2017. 7. 23..
//  Copyright
//  ImagePageScrollView.swift
//  TestApp
// © 2017년 hany. All rights reserved.
//

import UIKit

class ImagePageScrollView: UIScrollView {

    var images: [String]? {
        didSet {
            bindData()
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //스크롤 컨텐츠의 높이는 이미지 카운터 만큼해줘야한다.
    
    private func bindData(){
        guard let images = self.images else { return }
    
        let screenWidth = Int(UIScreen.main.bounds.width)
        let contentWidth = screenWidth * images.count
        self.contentSize = CGSize.init(width: contentWidth, height: screenWidth)
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension UIScrollViewDelegate {
    
}
