//
//  ApiManager.swift
//  USPolo-Ecommerse
//
//  Created by Mohammed Ramshad K on 25/03/21.
//

import Foundation
import Alamofire
class ApiManager: NSObject {
    static func callingProductList(parameter: [String:String],success: @escaping (Any)->Void){
        var productList = [Product]()
        AF.request("https://beta.gastro-admin.xyz/mobileapi/retail/get_top_sellers_products", method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil).responseJSON { result in
            switch(result.result) {
            case .success(_):
                if let resultData = result.value {
                    let products = resultData as! NSDictionary
                    if let data = products["products"] as? NSArray {
                        if(data.count > 0){
                            for index in 0..<data.count {
                                let values = data[index] as! NSDictionary
                                if let productId = values["product_id"] as? String, let productName =  values["name"] as? String , let image =  values["image"] as? String , let price =  values["price"] as? String,let rating =  values["rating"] as? String ?? "4.0"{
                                    let item = Product(product_id: productId, name: productName, image: image, price: price, rating: rating)
                                    productList.append(item)
                                }
                            }
                            success(productList)
                        }
                    }
                }
                break
            case .failure(_):
                break
            }
        }
    }
    
    static func CallingProductDetailApi(parameters: [String:String],success: @escaping (_ resonse: NSDictionary)->Void){
        AF.request("https://beta.gastro-admin.xyz/mobileapi/retail/get_product_details", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            switch(response.result) {
            case .success(_):
                if let response = response.value  as? NSDictionary{
                    if response != nil{
                        success(response )
                    }
                }
            case .failure(_):
            break
            }
                
           
        }
        
    }

}
