//
//  API+Favirot.swift
//  SHAMA
//
//  Created by Farido on 8/7/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API_Favirot: NSObject {
    class func categoriesFaveProduct (completion: @escaping (_ error: Error?,_ sparParts: [bestDimond]?,_ message: String?)-> Void) {
        
        let url = URLs.list_favorite_product
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang
        ]
        print(parameters)
        
        guard let userToken = helper.getAPIToken().token else {
            completion(nil,nil,nil)
            return
        }
        
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(userToken)"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil,nil)
                print(error)
                
            case .success(let value):
                let json = JSON(value)
                print(json)
                guard let dataArray = json["data"].array,let messsage = json["error"].string else{
                    completion(nil, nil,nil)
                    return
                }
                print(dataArray)
//                print(messsage)
                var products = [bestDimond]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = bestDimond.init(dict: data){
                        products.append(prodect)
                    }
                }
                print("taaaariq \(products)")
                completion(nil, products,messsage)
            }
        }
    }
    
    class func Prodectbanner (prodectid: Int,completion: @escaping (_ error: Error?,_ sparParts: [prodectImages]?)-> Void) {
        
        let url = URLs.products_images
        let parameters = [
            "product_id": prodectid
            ] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [prodectImages]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = prodectImages.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    class func prodectSize (colorID: Int,completion: @escaping (_ error: Error?,_ sparParts: [prodectSizes]?,_ message: String?)-> Void) {
        
        let url = URLs.products_size
        print(url)
        let parameters = [
            "color_id": colorID
            ] as [String : Any]
        print(parameters)
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let dataArray = json["data"].array,let messsage = json["error"].string else{
                    completion(nil, nil,nil)
                    return
                }
                print(dataArray)
                var products = [prodectSizes]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = prodectSizes.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products,messsage)
            }
        }
    }
    
    class func prodectTypes(prodectID: Int,completion: @escaping (_ error: Error?,_ sparParts: [prodectType]?,_ message: String?)-> Void) {
        
        let url = URLs.products_color_carat
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang,
            "product_id": prodectID
            ] as [String : Any]
        print(parameters)
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let dataArray = json["data"].array,let messsage = json["error"].string else{
                    completion(nil, nil,nil)
                    return
                }
                print(dataArray)
                var products = [prodectType]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = prodectType.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products,messsage)
            }
        }
    }
    
    class func prodectStyles(completion: @escaping (_ error: Error?,_ sparParts: [prodectStylessss]?)-> Void) {
        
        let url = URLs.all_carat_fillter_search
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang
            ] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [prodectStylessss]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = prodectStylessss.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    
    class func prodectStyle(completion: @escaping (_ error: Error?,_ sparParts: [prodectTypeGold]?,_ message: String?)-> Void) {
        
        let url = URLs.categoriesStandardGold
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang
            ] as [String : Any]
        print(parameters)
        
        guard let userToken = helper.getAPIToken().token else {
            completion(nil,nil,nil)
            return
        }
        
        let headers = [
            "Authorization": "Bearer \(userToken)"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let dataArray = json["data"].array,let messsage = json["message"].string else{
                    completion(nil, nil,nil)
                    return
                }
                print(dataArray)
                var products = [prodectTypeGold]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = prodectTypeGold.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products,messsage)
            }
        }
    }
    
    class func addFavProdect(prodectID: Int,completion: @escaping (_ error: Error?,_ status: Bool?,_ message: String?)-> Void) {
        
        let url = URLs.favorite_product
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang,
            "product_id": prodectID
            ] as [String : Any]
        print(parameters)
        
        guard let userToken = helper.getAPIToken().token else {
            completion(nil,nil,nil)
            return
        }
        
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(userToken)"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let status = json["status"].bool,let messsage = json["data"].string else{
                    completion(nil, nil,nil)
                    return
                }
                completion(nil, status,messsage)
            }
        }
    }
    
    
    class func addCartProdect(prodectID: Int,colorID: Int,size: String,carat: String,completion: @escaping (_ error: Error?,_ message: String?)-> Void) {
        
        let url = URLs.add_cart
        let parameters = [
            "product_id": prodectID,
            "product_quantity": 1,
            "color_id": colorID,
            "size": size,
            "carat": carat
            ] as [String : Any]
        print(parameters)
        
        guard let userToken = helper.getAPIToken().token else {
            completion(nil,nil)
            return
        }
        
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(userToken)"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let messsage = json["data"].string else{
                    completion(nil, nil)
                    return
                }
                completion(nil,messsage)
            }
        }
    }
    
    class func filterProdect (min_price: String,max_price: String,types_id: Int,carat_id: Int, men: Int, woman: Int,completion: @escaping (_ error: Error?,_ sparParts: [bestDimond]?)-> Void) {
        
        let url = URLs.fillter_search_all_products
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang,
            "men": men,
            "woman": woman,
            "carat_id": carat_id,
            "types_id": types_id,
            "max_price": max_price,
            "min_price": min_price
            ] as [String : Any]
        print(parameters)
        
        guard let userToken = helper.getAPIToken().token else {
            completion(nil,nil)
            return
        }
        
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(userToken)"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [bestDimond]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = bestDimond.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    class func deletCart(cart_id: Int,completion: @escaping (_ error: Error?,_ status: Int?,_ message: String?)-> Void) {
        
        let url = URLs.delete_cart
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang,
            "cart_id": cart_id
            ] as [String : Any]
        print(parameters)
        
        guard let userToken = helper.getAPIToken().token else {
            completion(nil,nil,nil)
            return
        }
        
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(userToken)"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let messsage = json["data"].string else{
                    completion(nil, nil,nil)
                    return
                }
                completion(nil, nil,messsage)
            }
        }
    }
    
    
    class func plusCart(cart_id: Int,completion: @escaping (_ error: Error?,_ status: Int?,_ message: String?)-> Void) {
        
        let url = URLs.plus_quentity_Cart
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang,
            "cart_id": cart_id
            ] as [String : Any]
        print(parameters)
        
        guard let userToken = helper.getAPIToken().token else {
            completion(nil,nil,nil)
            return
        }
        
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(userToken)"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let messsage = json["data"].string else{
                    completion(nil, nil,nil)
                    return
                }
                completion(nil, nil,messsage)
            }
        }
    }
    
    
    
    class func minCart(cart_id: Int,completion: @escaping (_ error: Error?,_ status: Int?,_ message: String?)-> Void) {
        
        let url = URLs.min_quentity_Cart
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang,
            "cart_id": cart_id
            ] as [String : Any]
        print(parameters)
        
        guard let userToken = helper.getAPIToken().token else {
            completion(nil,nil,nil)
            return
        }
        
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(userToken)"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, nil,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let messsage = json["data"].string else{
                    completion(nil, nil,nil)
                    return
                }
                completion(nil, nil,messsage)
            }
        }
    }
    
    class func createOrders(phone:String,totalPrice: Int,address: String,city: String,paymentMethod: Int,completion: @escaping (_ error: Error?,_ status: Bool?,_ message: String?)-> Void) {
        
        let url = URLs.create_order
        print(url)
        let parameters = [
            "payment_method": paymentMethod,
            "payment_status": 1,
            "customer_city": city,
            "customer_address": address,
            "order_total_price": totalPrice,
            "langtude": 0,
            "lattude": 0,
            "customer_phone": phone
            ] as [String : Any]
        print(parameters)
        
        guard let userToken = helper.getAPIToken().token else {
            completion(nil,false,nil)
            return
        }
        
        let headers = [
            "Accept": "application/json",
            "Authorization": "Bearer \(userToken)"
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers) .responseJSON  { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let messsage = json["data"].string, let status = json["status"].bool else{
                    completion(nil, false,nil)
                    return
                }
                completion(nil,status,messsage)
            }
        }
    }
}
