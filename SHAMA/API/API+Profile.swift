//
//  API+Profile.swift
//  SHAMA
//
//  Created by Farido on 8/19/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class API_Profile: NSObject {
    class func profileData(completion: @escaping (_ error: Error?,_ status: Bool?,_ profileData:[profile]?)-> Void) {
        
        let url = URLs.user_profile
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang
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
                completion(error,false,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let dataArray = json["data"].array else{
                    completion(nil,false,nil)
                    return
                }
                print(dataArray)
                var profileData = [profile]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = profile.init(dict: data){
                        profileData.append(prodect)
                    }
                }
                completion(nil, true,profileData)
                
            }
        }
    }
    
    class func aboutUs(completion: @escaping (_ error: Error?,_ status: Bool?,_ image: String?,_ title: String?,_ desc:String?)-> Void) {
        
        let url = URLs.about
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang
            ] as [String : Any]
        print(parameters)
        
        guard let userToken = helper.getAPIToken().token else {
            completion(nil,false,nil,nil,nil)
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
                completion(error,false,nil,nil,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let image = json["data"][0]["image"].string, let title = json["data"][0]["title"].string, let desc = json["data"][0]["description"].string else{
                    completion(nil,false,nil,nil,nil)
                    return
                }
                completion(nil, nil,image,title,desc)
                
            }
        }
    }
    
    class func counectUS(name: String,email: String,phone: String,message: String,completion: @escaping (_ error: Error?,_ message: String?)-> Void) {
        
        let url = URLs.contact_message
        print(url)
        let parameters = [
            "email": email,
            "name": name,
            "phone": phone,
            "message": message
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
                completion(error,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                
                if let data = json["data"].string{
                    completion(nil, data)
                }
                
                if json["message"].string != nil{
                    if let emailValidate = json["errors"]["email"][0].string{
                        completion(nil, emailValidate)
                    }else if let nameValidate = json["errors"]["name"][0].string{
                        completion(nil, nameValidate)
                    }else if let phoneValidate = json["errors"]["phone"][0].string{
                        completion(nil, phoneValidate)
                    }
                }
                
            }
        }
    }
    
    class func myorder (completion: @escaping (_ error: Error?,_ sparParts: [myorders]?)-> Void) {
        
        let url = URLs.order_list
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
                var products = [myorders]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = myorders.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products)
            }
        }
    }
    
    class func myorderDitales (order_id: String,completion: @escaping (_ error: Error?,_ sparParts: [myordersDitals]?,_ status: Bool?)-> Void) {
        
        let url = URLs.order_list_details
        print(url)
        let parameters = [
            "order_id": order_id
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
                completion(error, nil,false)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let dataArray = json["data"].array,let status = json["status"].bool else{
                    completion(nil, nil,nil)
                    return
                }
                print(dataArray)
                var products = [myordersDitals]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = myordersDitals.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil, products,status)
            }
        }
    }
    
    class func rateprodect (product_id: String,stars: String,comment: String, completion: @escaping (_ error: Error?,_ messsage: String?,_ message: String?)-> Void) {
        
        let url = URLs.categoriesAddRateComment
        print(url)
        let lang = "en".localized
        let parameters = [
            "lang": lang,
            "product_id": product_id,
            "stars": stars,
            "comment": comment
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
                completion(error,nil,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                guard let messsagez = json["message"].string else{
                    completion(nil,nil,nil)
                    return
                }
                
                if let messsage = json["message"].string{
                    completion(nil, messsagez,messsage)
                }
                
            }
        }
    }
    
    class func editProfile (name: String,email: String,phone: String, completion: @escaping (_ error: Error?,_ message: String?)-> Void) {
        
        let url = URLs.update_profile
        print(url)
        let parameters = [
            "name": name,
            "email": email,
            "phone": phone
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
                completion(error,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                print(json)
                if let data = json["data"].string{
                    completion(nil, data)
                }
                if json["message"].string != nil{
                    if let emailValidate = json["errors"]["email"][0].string{
                        completion(nil, emailValidate)
                    }else if let nameValidate = json["errors"]["name"][0].string{
                        completion(nil, nameValidate)
                    }else if let phoneValidate = json["errors"]["phone"][0].string{
                        completion(nil, phoneValidate)
                    }
                }
                
            }
        }
    }
}
