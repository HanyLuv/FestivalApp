import UIKit

class BestPlaceItemCell: UICollectionViewCell {
    
    static let identifier = "BestPlaceItemCellIdentifire"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    var festival: Festival?{
        didSet{
            bindData()
        }
    }
    
    private func bindData(){
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

