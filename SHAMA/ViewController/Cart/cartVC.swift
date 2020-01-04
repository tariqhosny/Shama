//
//  cartVC.swift
//  SHAMA
//
//  Created by Farido on 8/18/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class cartVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    @IBOutlet weak var cartListLabel: UILabel!
    @IBOutlet weak var topItemOUt: UILabel!
    @IBOutlet weak var chechBTN: UIButtonView!
    @IBOutlet weak var buttomItem: UILabel!
    @IBOutlet weak var totalWithoutEXT: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var taxes: UILabel!
    @IBOutlet weak var taxesValue: UILabel!
    @IBOutlet weak var delivery: UILabel!
    @IBOutlet weak var dilveryValue: UILabel!
    
    var cart = [cartData]()
    var totalPrice = 0
    var totalTextes = 0
    var totalDeviery = 0
    var allTotale = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //spiner.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
        //handleRefreshFavProdect()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handleRefreshFavProdect()
    }
    
    @IBAction func cheackOUtBTN(_ sender: Any) {
        performSegue(withIdentifier: "suge", sender: nil)
    }
    
    func handleRefreshFavProdect() {
        self.totalPrice = 0
        self.totalTextes = 0
        self.totalDeviery = 0
        self.spiner.isHidden = false
        self.spiner.startAnimating()
        
       

        API_Home.carts { (error: Error?, cart: [cartData]?, taxes, delivery, price) in
            
            if let cart = cart {
                self.cart = cart
                print("sdsds\(self.cart)")
                self.tableView.reloadData()
            }
            if self.cart.count == 0{
                self.tableView.isHidden = true
                self.cartListLabel.isHidden = true
                self.topItemOUt.isHidden = true
                self.chechBTN.isHidden = true
                self.totalWithoutEXT.isHidden = true
                self.total.isHidden = true
                self.totalValue.isHidden = true
                self.taxesValue.isHidden = true
                self.delivery.isHidden = true
                self.dilveryValue.isHidden = true
                self.taxes.isHidden = true
                self.buttomItem.isHidden = true
                if let tabItems = self.tabBarController?.tabBar.items {
                    let tabItem = tabItems[2]
                    tabItem.badgeValue = nil
                }
                self.cart = []
                print("zzxxxx")
                self.tableView.reloadData()
            }else {
                self.tableView.isHidden = false
                self.cartListLabel.isHidden = false
                self.topItemOUt.isHidden = false
                self.chechBTN.isHidden = false
                self.totalWithoutEXT.isHidden = false
                self.total.isHidden = false
                self.totalValue.isHidden = false
                self.taxesValue.isHidden = false
                self.delivery.isHidden = false
                self.dilveryValue.isHidden = false
                self.taxes.isHidden = false
                self.buttomItem.isHidden = false
                if let tabItems = self.tabBarController?.tabBar.items {
                    let tabItem = tabItems[2]
                    tabItem.badgeValue = "\(self.cart.count)"
                    self.topItemOUt.text = "\(self.cart.count) "+"Items".localized
                    self.buttomItem.text = "\(self.cart.count) "+"Items".localized
                    
                    for item in self.cart {
                        self.totalPrice = item.totalprice + self.totalPrice
                    }
                    
                    self.totalWithoutEXT.text = "\(self.totalPrice)$"
                    self.taxesValue.text = "\(taxes ?? 0)$"
                    self.dilveryValue.text = "\(delivery ?? "")$"
                    self.totalValue.text = "\(price ?? 0)$"
                    self.allTotale = price ?? 0
                }
            }
            self.spiner.isHidden = true
            self.spiner.stopAnimating()
        }
        
    }
    
    func deletCart(cartId: Int?){
        API_Favirot.deletCart(cart_id: cartId ?? 0) { (error, data,massage)  in
            self.showAlert(title: "cart".localized, message: massage ?? "")
            self.handleRefreshFavProdect()
        }
    }
    
    func PluseCart(cartId: Int?){
        API_Favirot.plusCart(cart_id: cartId ?? 0) { (error, data,massage)  in
            self.showAlert(title: "cart".localized, message: massage ?? "")
            self.handleRefreshFavProdect()
        }
    }
    
    func mainCart(cartId: Int?){
        API_Favirot.minCart(cart_id: cartId ?? 0) { (error, data,massage)  in
            self.showAlert(title: "cart".localized, message: massage ?? "")
            self.handleRefreshFavProdect()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? checkOutVC{
            destaiantion.totalPrice = allTotale
        }
    }
    
}



extension cartVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? cartCell{
            let fav = cart[indexPath.row]
            cell.configuerCell(prodect: fav)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.deleteBtn = {
                self.deletCart(cartId: fav.id)
            }
            cell.add = {
                self.PluseCart(cartId: fav.id)
            }
            
            if fav.qty == "1" {
                cell.minBTN.isEnabled = false
            }else {
                cell.minBTN.isEnabled = true
                cell.min = {
                self.mainCart(cartId: fav.id)
            }
        }
            
            return cell
        }else {
            return cartCell()
        }
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        performSegue(withIdentifier: "suge", sender: favProdect[indexPath.row])
    //    }
    //
}



