//
//  ProductDescriptionTableViewCell.swift
//  USPolo-Ecommerse
//
//  Created by Mohammed Ramshad K on 25/03/21.
//

import UIKit

class ProductDescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(name : String, detail : String, rating : String){
        productName.text = name
        productDescription.text = detail
        ratingLabel.text = rating
    }
}
