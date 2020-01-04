//
//  API+Home.swift
//  SHAMA
//
//  Created by Farido on 8/4/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class API_Home: NSObject {
    
    class func banner (completion: @escaping (_ error: Error?,_ sparParts: [banners]?)-> Void) {
        
        let url = URLs.slider
        let lang = "en".localized
        let parameters = [
            "lang": lang
        ]
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
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
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [banners]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = banners.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    class func allTypesApi (completion: @escaping (_ error: Error?,_ sparParts: [allTypes]?)-> Void) {
        
        let url = URLs.all_types_fillter_search
        let lang = "en".localized
        let parameters = [
            "lang": lang
        ]
        
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
                var products = [allTypes]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = allTypes.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    class func sections (completion: @escaping (_ error: Error?,_ sparParts: [category]?)-> Void) {
            
            let url = URLs.sections
            let lang = "en".localized
            let parameters = [
                "lang": lang
            ]
            
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
                    var products = [category]()
                    for data in dataArray {
                        if let data = data.dictionary, let prodect = category.init(dict: data){
                            products.append(prodect)
                        }
                    }
                    completion(nil, products)
                }
            }
        }
    
    class func categories (completion: @escaping (_ error: Error?,_ sparParts: [category]?)-> Void) {
        
        let url = URLs.categories
        let lang = "en".localized
        let parameters = [
            "lang": lang
        ]
        
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
                var products = [category]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = category.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }

    class func Subcategories (category_id: Int,completion: @escaping (_ error: Error?,_ sparParts: [category]?)-> Void) {
        
        let url = URLs.categories
        let lang = "en".localized
        let parameters = [
            "lang": lang,
            "section_id": category_id
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
                var products = [category]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = category.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }

    
    class func bestDaimond (completion: @escaping (_ error: Error?,_ sparParts: [bestDimond]?)-> Void) {
        
        let url = URLs.feature_products
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang
        ]
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
    
    class func allProdect (subcategory_id: Int,completion: @escaping (_ error: Error?,_ sparParts: [bestDimond]?)-> Void) {
        
        let url = URLs.products_category
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang,
            "category_id": subcategory_id
            ] as [String : Any]
        print(parameters)
        
        guard let userToken = helper.getAPIToken().token else {
            completion(nil,nil)
            return
        }
        
        let headers = [
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

    
    class func carts (completion: @escaping (_ error: Error?,_ sparParts: [cartData]?,_ taxes: Int?,_ delivery: String?,_ price: Int?)-> Void){
        
        let url = URLs.list_data_cart
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang,
            ] as [String : Any]
        print(parameters)
        
        guard let userToken = helper.getAPIToken().token else {
            completion(nil,nil,nil,nil,nil)
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
                completion(error, nil,nil,nil,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let dataArray = json["data"]["list"].array,let taxes = json["data"]["total_tax"].int, let delivery = json["data"]["total_delevery_fees"].string,let price = json["data"]["price"].int else{
                    completion(nil, nil,nil,nil,nil)
                    return
                }
                print(dataArray)
                var products = [cartData]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = cartData.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products,taxes,delivery,price)
                
            }
        }
    }
    
}
