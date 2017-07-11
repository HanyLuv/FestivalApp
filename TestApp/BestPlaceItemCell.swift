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
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

