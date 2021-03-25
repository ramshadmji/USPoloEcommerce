//
//  ProductDetailViewController.swift
//  USPolo-Ecommerse
//
//  Created by Mohammed Ramshad K on 25/03/21.
//

import Foundation
import UIKit
class ProductDetailViewController: BaseViewController{
    @IBOutlet weak var DetailTableView: UITableView!
    
    var itemPrice: String = ""
    var itemOptions : [ProductOptions] = []
    var related : [RelatedProducts] = []
    var name : String = ""
    var price : String = ""
    var details : String = ""
    var rating : String = ""
    var product_id : String = ""
    var parameters = [String:String]()
    var itemImages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DetailTableView.delegate = self
        DetailTableView.dataSource = self
        DetailTableView.register(UINib.init(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
        DetailTableView.register(UINib.init(nibName: "ProductDescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductDescriptionTableViewCell")
        DetailTableView.register(UINib.init(nibName: "ItemOptionsTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemOptionsTableViewCell")
        DetailTableView.register(UINib.init(nibName: "AddToCartTableViewCell", bundle: nil), forCellReuseIdentifier: "AddToCartTableViewCell")
        
        
        parameters.updateValue("69", forKey: "user_id")
        parameters.updateValue("iOS", forKey: "device_type")
        parameters.updateValue("69", forKey: "customer_id")
        parameters.updateValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjdXN0b21lcl9pZCI6IjY5IiwiaWF0IjoxNjA2ODgzNjE3fQ.QK13epjPKnc-twJCwObDVNenfPsmw2HR1f9lJUG3CEo", forKey: "token")
        parameters.updateValue("1", forKey: "language_id")
        parameters.updateValue("225", forKey: "country_id")
        parameters.updateValue("1716", forKey: "area_id")
        parameters.updateValue(product_id, forKey: "product_id")
        callingDetailApi()
    }
    
    func callingDetailApi(){
        ApiManager.CallingProductDetailApi(parameters: parameters) { [self] (resopnse) in
            
            if let product_details = resopnse["product_details"] as? NSDictionary{
                self.name = product_details["name"] as? String ?? ""
                self.details = product_details["description"] as? String ?? ""
                self.rating = product_details["rating"] as? String ?? "5.0"
                self.price = product_details["price"] as? String ?? "0.0"
                
                if let images = product_details["images"] as? NSArray {
                    if(images.count > 0){
                        for index in 0..<images.count{
                            let img = images[index] as? String ?? ""
                            self.itemImages.append(img)
                        }
                        
                    }
                }
                if let product_options = resopnse["product_options"] as? NSArray {
                    if(product_options.count > 0){
                        for index in 0..<product_options.count{
                            if let item = product_options[index] as? NSDictionary {
                                let name = item["name"] as? String ?? ""
                                var product_optionArray : [ProductOptionValue] = []
                                if let temp =  item["product_option_value"] as? NSArray {
                                    for a in temp {
                                        if let dta = a as? NSDictionary {
                                            let product_option_value_id = dta["product_option_value_id"] as? String ?? ""
                                            let name = dta["name"] as? String ?? ""
                                            let color_code = dta["color_code"] as? String ?? ""
                                            product_optionArray.append(ProductOptionValue(product_option_value_id: product_option_value_id, name: name, color_code: color_code))
                                        }
                                    }
                                }
                                
                                self.itemOptions.append(ProductOptions(name: name, product_option_value: product_optionArray))
                                
                            }
                        }
                        
                    }
                }
                if let temp =  resopnse["related_products"] as? NSArray {
                    for a in temp {
                        if let dta = a as? NSDictionary {
                            let product_id = dta["product_id"] as? String ?? ""
                            let name = dta["name"] as? String ?? ""
                            let price = dta["price"] as? String ?? ""
                            let image = dta["image"] as? String ?? ""
                            self.related.append(RelatedProducts(product_id: product_id, name: name, price: price, image: image))
                        }
                    }
                }
                
                self.DetailTableView.reloadData()
                
            }
            
        }
    }
}
extension ProductDetailViewController: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if itemPrice != ""{
            return 5
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return itemOptions.count
        case 3:
            return 1
        case 4:
            if related.count > 0 {
                return 1
            }else{
                return 0
            }
        default:
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }else if indexPath.section == 1 {
            return UITableView.automaticDimension
        }else if indexPath.section == 2 {
            return UITableView.automaticDimension
        }else if indexPath.section == 3 {
            return UITableView.automaticDimension
        }else if indexPath.section == 4 {
            return 320
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath) as! ImageTableViewCell
            //            cell.slider.setImageInputs(self.alamofireSource)
            //            cell.slider.backgroundColor = UIColor.white
            //            cell.slider.pageIndicator?.view.tintColor = .black
            //            cell.slider.pageIndicator?.view.borderColorV = .black
            //            cell.slider.slideshowInterval = 5.0
            //            cell.slider.contentScaleMode = UIViewContentMode.scaleAspectFit
            return cell
        }else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDescriptionTableViewCell", for: indexPath) as! ProductDescriptionTableViewCell
            cell.prepareForReuse()
            cell.setData(name: name, detail: details, rating: rating)
            return cell
        }else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemOptionsTableViewCell", for: indexPath) as! ItemOptionsTableViewCell
            cell.prepareForReuse()
            cell.setData(item: itemOptions[indexPath.row], name: itemOptions[indexPath.row].name)
            return cell
        }else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddToCartTableViewCell", for: indexPath) as! AddToCartTableViewCell
            cell.itemPrice.text = "$ " + price
            return cell
        }
        //        }else if indexPath.section == 4 {
        //            let cell = tableView.dequeueReusableCell(withIdentifier: "RelatedTblCell", for: indexPath) as! RelatedTblCell
        //            cell.related = self.related
        //            cell.delegate = self
        //            return cell
        //        }
        return UITableViewCell()
    }
    
    
}
