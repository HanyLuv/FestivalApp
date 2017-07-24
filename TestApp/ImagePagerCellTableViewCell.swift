//
//  ImagePagerCellTableViewCell.swift
//  TestApp
//
//  Created by 김환희 on 2017. 7. 23..
//  Copyright © 2017년 hany. All rights reserved.
//

import UIKit

class ImagePagerCellTableViewCell: UITableViewCell, NibLoadableView, ReusableView{
    @IBOutlet weak var scrollView: UIScrollView!
    
    var images: [Image]? {
        didSet {
            
            bindData()
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func bindData(){
        guard let images = self.images else { return }
        
        let width = Int(UIScreen.main.bounds.width)
        let contentsWidth = width * images.count
        scrollView.contentSize = CGSize.init(width: contentsWidth, height: width)
        scrollView.backgroundColor = UIColor.blue
        scrollView.isPagingEnabled = true
    
        var imageX = 0
        var imageArray: [UIImageView] = []
        for (index, image) in images.enumerated() {
            //1:1비율
            let imageView = UIImageView(frame: CGRect.init(x: imageX, y: 0, width: width, height: width))
            imageX = imageX + width
            imageView.contentMode = .scaleAspectFill
            scrollView.addSubview(imageView)
            imageArray.append(imageView)
            
            if let strURL = image.originimgurl {
                HttpManager.sharedManager.fetchImage(withImageStringURL: strURL, key: String.init(index)) { (image, key) in
                    
                    guard let image = image, let key = Int.init(key) else { return }
                    DispatchQueue.main.async {
                        imageArray[key].image = image
                    }
                    
                    
                }
            }
        }
        
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
