//
//  homeData.swift
//  SHAMA
//
//  Created by Farido on 8/4/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import SwiftyJSON

class homeData: NSObject {

}

class banners: NSObject {
    
    var image: String
    
    init?(dict: [String: JSON]){
        
        guard let image = dict["image"]?.string else {return nil}
        self.image = image
        
    }
}

//"name": "Test category 1",
//"photo": "15644818577333.jpg",
//"id": 23

class category: NSObject {
    
    var name: String
    var photo: String
    var id: Int
    
    
    init?(dict: [String: JSON]){
        
        guard let name = dict["title"]?.string,let photo = dict["image"]?.string,let id = dict["id"]?.int else {return nil}
        self.name = name
        self.photo = photo
        self.id = id
        
    }
}

class profile: NSObject {
    
    var name: String
    var email: String
    var phone: String
    var total_amount: Int
    var count_orders: String
    var count_product: Int
    
    
    init?(dict: [String: JSON]){
        
        if let name = dict["name"]?.string {
            self.name = name
        }else {
            self.name = ""
        }
        
        if let email = dict["email"]?.string {
            self.email = email
        }else {
            self.email = ""
        }
        
        if let phone = dict["phone"]?.string {
            self.phone = phone
        }else {
            self.phone = ""
        }
        
        if let total_amount = dict["total_amount"]?.int {
            self.total_amount = total_amount
        }else {
            self.total_amount = 0
        }
        
        if let count_orders = dict["count_orders"]?.string {
            self.count_orders = count_orders
        }else {
            self.count_orders = ""
        }
        
        if let count_product = dict["count_product"]?.int {
            self.count_product = count_product
        }else {
            self.count_product = 0
        }
        
    }
}


class bestDimond: NSObject {
    
    var id: Int
    var product_id: Int
    var name: String
    var title: String
    var details: String
    var photo: String
    var SalesPrice: Float
    var OriginalPrice: Float
    var caliber: String
    var favorite: Int
    var Rate: Int
    var total_rate_av: Int
    
    init?(dict: [String: JSON]){
        if let total_rate_av = dict["total_rate_av"]?.int {
            self.total_rate_av = total_rate_av
        }else {
            self.total_rate_av = 0
        }
        
        if let Rate = dict["rates"]?.int {
            self.Rate = Rate
        }else {
            self.Rate = 0
        }
        
        if let title = dict["title"]?.string {
            self.title = title
        }else {
            self.title = ""
        }
        
        if let favorite = dict["Wishlist_state"]?.int {
            self.favorite = favorite
        }else {
            self.favorite = 0
        }
        
        if let caliber = dict["carat"]?.string {
            self.caliber = caliber
        }else {
            self.caliber = ""
        }
        
        if let product_id = dict["product_id"]?.string {
            self.product_id = Int(product_id) ?? 0
        }else {
            self.product_id = 0
        }
        
        if let id = dict["id"]?.int {
            self.id = id
        }else {
            self.id = 0
        }
        
        if let name = dict["name"]?.string {
            self.name = name
        }else {
            self.name = ""
        }
        
        if let details = dict["description"]?.string {
            self.details = details
        }else {
            self.details = ""
        }
        
        if let photo = dict["image"]?.string {
            self.photo = photo
        }else {
            self.photo = ""
        }
        if let SalesPrice = dict["sale_price"]?.string {
            self.SalesPrice = Float(SalesPrice)!
        }else {
            self.SalesPrice = 0.0
        }
        if let OriginalPrice = dict["price_general"]?.string {
            self.OriginalPrice = Float(OriginalPrice)!
        }else {
            self.OriginalPrice = 0.0
        }
    }
}
