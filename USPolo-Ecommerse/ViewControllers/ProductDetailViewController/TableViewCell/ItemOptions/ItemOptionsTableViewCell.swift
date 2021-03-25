//
//  ItemOptionsTableViewCell.swift
//  USPolo-Ecommerse
//
//  Created by Mohammed Ramshad K on 25/03/21.
//

import UIKit

class ItemOptionsTableViewCell: UITableViewCell {
    
    var selectIndex : Int = 0
    var items : ProductOptions?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var CollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        CollectionView.dataSource = self
        CollectionView.delegate = self
        CollectionView.register(UINib.init(nibName: "ChooseSizeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ChooseSizeCollectionViewCell")
        CollectionView.register(UINib.init(nibName: "ChooseColorCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ChooseColorCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(item : ProductOptions, name : String){
        titleLabel.text = name
        self.items = item
        self.CollectionView.reloadData()
    }
}
extension ItemOptionsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (items?.product_option_value.count)!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if items?.product_option_value[indexPath.row].color_code == ""{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChooseSizeCollectionViewCell", for: indexPath) as! ChooseSizeCollectionViewCell
            if selectIndex == indexPath.row {
                cell.backgroundColor  = .systemGreen
                
            }else{
                cell.backgroundColor = .clear
               
            }
            cell.sizeLabel.text = items?.product_option_value[indexPath.row].name.uppercased()
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChooseColorCollectionViewCell", for: indexPath) as! ChooseColorCollectionViewCell
            if selectIndex == indexPath.row {
                cell.backgroundColor = .systemGreen
                //cell.bgView.borderWidthV = 1
            }else{
                cell.backgroundColor = .clear
                //cell.bgView.borderWidthV = 0
            }
            cell.colorView.backgroundColor = .hexStringToUIColor(hex: (items?.product_option_value[indexPath.row].color_code)!)
            return cell
        } 
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 30, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectIndex = indexPath.row
        self.CollectionView.reloadData()
    }
    
    
    
}
extension UIColor{
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
