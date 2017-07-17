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
        
        
        if let key = festival.key, let image = ImageCache.shared.imageFromDiskCache(forKey: key) {
            self.imageView.image = image
        
        } else {
            HttpManager.sharedManager.fetchFestivalPhotoImage(withFestival: festival) { [weak self] (image, key) in
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

