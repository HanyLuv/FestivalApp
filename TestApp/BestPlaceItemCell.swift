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
            
            
            HttpManager.sharedManager.fetchFestivalPhotoImage(withDataDictionary: data) { [weak self] (image) in
                guard let wself = self, let image = image else { return }
                
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

