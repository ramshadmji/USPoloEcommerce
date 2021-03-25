//
//  ProductListTableViewCell.swift
//  USPolo-Ecommerse
//
//  Created by Mohammed Ramshad K on 24/03/21.
//

import UIKit
import Kingfisher

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productType: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var rating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(prod : Product){
        rate.text = "$ " + prod.price
        rating.text = prod.rating
        productType.text = prod.category
        productName.text = prod.name
        productImage.kf.setImage(with: URL(string: "https://d2tcyife2dgcgh.cloudfront.net/image/" + prod.image))
//        if let link = prod.image.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
//            let imgUrl = "https://d2tcyife2dgcgh.cloudfront.net/image/" + link
//            imgView.af.setImage(withURL: URL(string: imgUrl)!)
//        }
    }
}
