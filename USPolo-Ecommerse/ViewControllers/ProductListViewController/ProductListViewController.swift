//
//  ProductListViewController.swift
//  USPolo-Ecommerse
//
//  Created by Mohammed Ramshad K on 24/03/21.
//

import Foundation
import UIKit

class ProductListViewController: BaseViewController {
    @IBOutlet weak var productListTableView: UITableView!
    var prodcutList: [Product] = []
    var parameters = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productListTableView.delegate = self
        productListTableView.dataSource = self
        productListTableView.register(UINib.init(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListTableViewCell")
        parameters.updateValue("69", forKey: "user_id")
        parameters.updateValue("iOS", forKey: "device_type")
        parameters.updateValue("69", forKey: "customer_id")
        parameters.updateValue("eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJjdXN0b21lcl9pZCI6IjY5IiwiaWF0IjoxNjA2ODgzNjE3fQ.QK13epjPKnc-twJCwObDVNenfPsmw2HR1f9lJUG3CEo", forKey: "token")
        parameters.updateValue("1", forKey: "language_id")
        parameters.updateValue("225", forKey: "country_id")
        parameters.updateValue("1", forKey: "main_category_id")
        parameters.updateValue("6", forKey: "category_id_l2")
        parameters.updateValue("2", forKey: "category_id_l1")
        parameters.updateValue("1716", forKey: "area_id")
        callingProductListApi()
    }
    func callingProductListApi() {
        ApiManager.callingProductList(parameter: parameters) { [self] (result) in
            prodcutList.removeAll()
            prodcutList = result as! [Product]
            productListTableView.reloadData()
        }
    }
    
}
extension ProductListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if prodcutList.count > 0 {
            return UITableView.automaticDimension
        }else{
            return 115
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if prodcutList.count > 0 {
            return prodcutList.count
        }else{
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productListTableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell", for: indexPath) as! ProductListTableViewCell
        if prodcutList.count>0{
            
            cell.prepareForReuse()
            cell.setData(prod: prodcutList[indexPath.row])
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if prodcutList.count>0{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let DetailVC = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
            DetailVC.product_id = prodcutList[indexPath.row].product_id
            self.navigationController?.pushViewController(DetailVC, animated: true)
        }
    }
}
