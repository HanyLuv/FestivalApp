import UIKit

class BestPlaceItemCell: BaseCollectionViewCell {
    
    static let identifier = "BestPlaceItemCellIdentifire"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func bindData(){
        guard let festival = festival else {
            return
        }
        
        titleLabel.text = festival.title
        
        if let contentId = festival.contentid, let imageURL = festival.firstimage {
            
            let data: [String: String] = ["contentId" : String(contentId), "imageURL": imageURL ]
            
            /*
            guard let contentId = data["contentId"], let strURL = data["imageURL"] else {
                return
            }
            
            let key = String.init(format: "%@%@", strURL, contentId)
            */
            if let key = festival.key, let image = ImageCache.shared.imageFromDiskCache(forKey: festival.key) {
                
            }
     
            
            HttpManager.sharedManager.fetchFestivalPhotoImage(withDataDictionary: data) { [weak self] (image, key) in
                guard let wself = self, let image = image else { return }
                
                ImageCache.shared.store(image, forKey: key)
                DispatchQueue.main.async {
                    wself.imageView.image = image
    
                }
                
            }
            
        }
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFit
        // Initialization code
    }
    
}

