//
//  prodectsDeitals.swift
//  SHAMA
//
//  Created by Farido on 8/7/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class prodectsDeitals: NSObject {

}


class prodectImages: NSObject {
    
    var image: String
    
    init?(dict: [String: JSON]){
        
        if let image = dict["image"]?.string {
            self.image = image
        }else {
            self.image = ""
        }
        
    }
}

class prodectSizes: NSObject {
    var id: Int
    var size: String
    var offer_price: String
    var price: String
    
    init?(dict: [String: JSON]){
        
        if let offer_price = dict["offer_price"]?.string {
            self.offer_price = offer_price
        }else {
            self.offer_price = ""
        }
        
        if let price = dict["price"]?.string {
            self.price = price
        }else {
            self.price = ""
        }
        
        guard let id = dict["id"]?.int,let size = dict["size"]?.string else {return nil}
        self.id = id
        self.size = size
        
    }
}


class prodectType: NSObject {
    var id: Int
    var color: String
    var carat: String
    
    init?(dict: [String: JSON]){
        
        if let id = dict["id"]?.int {
            self.id = id
        }else {
            self.id = 0
        }
        
        if let color = dict["color"]?.string {
            self.color = color
        }else {
            self.color = ""
        }
        
        if let carat = dict["carat"]?.string {
            self.carat = carat
        }else {
            self.carat = ""
        }
        
    }
}

class allTypes: NSObject {
    var id: Int
    var size: String
    var color: String
    
    init?(dict: [String: JSON]){
        
        if let id = dict["id"]?.int {
            self.id = id
        }else {
            self.id = 0
        }
        
        if let size = dict["size"]?.string {
            self.size = size
        }else {
            self.size = ""
        }
        
        if let color = dict["color"]?.string {
            self.color = color
        }else {
            self.color = ""
        }
        
    }
}

class prodectStylessss: NSObject {
    var id: Int
    var name: String
    var image: String
    
    init?(dict: [String: JSON]){
        
        if let image = dict["image"]?.string {
            self.image = image
        }else {
            self.image = ""
        }
        
        if let id = dict["id"]?.int {
            self.id = id
        }else {
            self.id = 0
        }
        
        if let name = dict["title"]?.string {
            self.name = name
        }else {
            self.name = ""
        }
    }
}



class prodectTypeGold: NSObject {
    var id: Int
    var name: String
    
    init?(dict: [String: JSON]){
        
        guard let id = dict["id"]?.int,let name = dict["name"]?.string else {return nil}
        self.id = id
        self.name = name
    }
}

class cartData: NSObject {
    var id: Int
    var name: String
    var photo: String
    var totalprice: Int
    var price: String
    var qty: String
    var size: String
    var caliber: String
    
    init?(dict: [String: JSON]){
        
        if let size = dict["size"]?.string {
            self.size = size
        }else {
            self.size = "0"
        }
        
        if let caliber = dict["carat"]?.string {
            self.caliber = caliber
        }else {
            self.caliber = "0"
        }
        
        if let id = dict["cart_id"]?.int {
            self.id = id
        }else {
            self.id = 0
        }
        
        if let name = dict["product_name"]?.string {
            self.name = name
        }else {
            self.name = "0"
        }
        
        if let photo = dict["image"]?.string {
            self.photo = photo
        }else {
            self.photo = "0"
        }
        
        if let totalprice = dict["total_unit_price"]?.int {
            self.totalprice = totalprice
        }else {
            self.totalprice = 0
        }
        
        if let price = dict["unit_price"]?.string {
            self.price = price
        }else {
            self.price = "0"
        }
        
        if let qty = dict["quantity"]?.string {
            self.qty = qty
        }else {
            self.qty = "0"
        }
    }
}


class myorders: NSObject {
    var id: Int
    var totalPrice: String
    var orderDate: String
    var status: String
    var address: String
    var payment_type: String
    var deliveryFees: String
    var city: String
    var taxes: Int
    
    init?(dict: [String: JSON]){
        
        if let id = dict["order_id"]?.int {
            self.id = id
        }else {
            self.id = 0
        }
        
        if let totalPrice = dict["order_total_price"]?.string {
            self.totalPrice = totalPrice
        }else {
            self.totalPrice = "0"
        }
        
        if let orderDate = dict["created_at"]?.string {
            self.orderDate = orderDate
        }else {
            self.orderDate = "0"
        }
        
        if let status = dict["payment_status"]?.string {
            self.status = status
        }else {
            self.status = "0"
        }
        
        if let address = dict["customer_address"]?.string {
            self.address = address
        }else {
            self.address = "0"
        }
        
        if let payment_type = dict["payment_method"]?.string {
            self.payment_type = payment_type
        }else {
            self.payment_type = "0"
        }
        
        if let deliveryFees = dict["delevery_fees"]?.string {
            self.deliveryFees = deliveryFees
        }else {
            self.deliveryFees = "0"
        }
        
        if let city = dict["customer_city"]?.string {
            self.city = city
        }else {
            self.city = "0"
        }
        
        if let taxes = dict["taxes"]?.int {
            self.taxes = taxes
        }else {
            self.taxes = 0
        }
    }
}

class myordersDitals: NSObject {
    var id: Int
    var name: String
    var photo: String
    var price: String

    
    init?(dict: [String: JSON]){
        if let id = dict["product_id"]?.int {
            self.id = id
        }else {
            self.id = 0
        }
        
        if let name = dict["product_name"]?.string {
            self.name = name
        }else {
            self.name = ""
        }
        
        if let photo = dict["image"]?.string {
            self.photo = photo
        }else {
            self.photo = ""
        }
        
        if let price = dict["product_price"]?.string {
            self.price = price
        }else {
            self.price = ""
        }
        
    }
}
