//
//  AddToCartTableViewCell.swift
//  USPolo-Ecommerse
//
//  Created by Mohammed Ramshad K on 25/03/21.
//

import UIKit

class AddToCartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemCountLabel: UILabel!
    
    @IBOutlet weak var itemPrice: UILabel!
    var count : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func plusClicked(_ sender: Any) {
        count = count + 1
        itemCountLabel.text = "\(count)"
    }
    
    @IBAction func minusClicked(_ sender: Any) {
        if count != 1 {
            count = count - 1
            itemCountLabel.text = "\(count)"
        }
    }
    
}
