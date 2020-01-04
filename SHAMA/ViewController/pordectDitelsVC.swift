//
//  pordectDitelsVC.swift
//  SHAMA
//
//  Created by Farido on 8/7/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Cosmos

class pordectDitelsVC: UIViewController {
 
    @IBOutlet weak var bannerCollocationView: UICollectionView!
    @IBOutlet weak var page: UIPageControl!
    @IBOutlet weak var reate: CosmosView!
    @IBOutlet weak var totalRate: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var favortBtn: UIButton!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var TypeTF: UITextField!
    @IBOutlet weak var sizeTF: UITextField!
    
    var timer = Timer()
    var counter = 0
    var sizess = 0
    var typess = 0
    var cart = [cartData]()
    var isFavorite = 0
    var id = Int()
    var colorId = 0
    var colorName = String()
    var size = String()
    var carat = String()
    var prodectBanner = [prodectImages]()
    var sizes = [prodectSizes]()
    var types = [prodectType]()
    var singleItem: bestDimond?
    var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
        print("iddddd \(id)")
        
        bannerCollocationView.dataSource = self
        bannerCollocationView.delegate = self
        
        handleRefreshgetBanner()
        handleRefreshgetProdectType()
        
        
        textEnabeld()
        createTypePiker()
        createSizePiker()
    }
    
    
    
    func createToolbar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //Customizations
        toolBar.barTintColor = .black
        toolBar.tintColor = .white
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(pordectDitelsVC.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        TypeTF.inputAccessoryView = toolBar
        sizeTF.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @objc private func handleRefreshgetProdectSize() {
        API_Favirot.prodectSize(colorID: colorId ){(error: Error?, sizes: [prodectSizes]?,data) in
            if let sizes = sizes {
                self.sizes = sizes
                self.size = self.sizes[0].size
                self.sizeTF.text = self.size
                if Int(sizes[0].offer_price) != 0 {
                    self.price.text = "\(sizes[0].offer_price) $"
                }else{
                    self.price.text = "\(sizes[0].price) $"
                }
                print("xxx\(self.sizes)")
                self.textEnabeld()
                }
            }
        }
    
    @objc private func handleRefreshgetProdectType() {
        API_Favirot.prodectTypes(prodectID: id ){(error: Error?, types: [prodectType]?,data) in
            if let types = types {
                self.types = types
                self.carat = self.types[0].carat
                self.TypeTF.text = self.carat
                self.colorId = self.types[0].id
                self.colorName = self.types[0].color
                self.setColorToTextField()
                self.handleRefreshgetProdectSize()
                print("xxxdscasdvc\(self.types)")
                self.textEnabeld()
            }
        }
    }
    
    func textEnabeld() {
        
        if sizes.isEmpty == true {
            sizeTF.isEnabled = false
        }else {
            sizeTF.isEnabled = true
        }
        
        if types.isEmpty == true {
            TypeTF.isEnabled = false
        }else {
            TypeTF.isEnabled = true
        }
    }
    
    func createSizePiker(){
        let sizex = UIPickerView()
        sizex.delegate = self
        sizex.dataSource = self
        sizex.tag = 0
        sizeTF.inputView = sizex
        handleRefreshgetProdectSize()
        sizex.reloadAllComponents()
    }
    
    func createTypePiker(){
        let type = UIPickerView()
        type.delegate = self
        type.dataSource = self
        type.tag = 1
        TypeTF.inputView = type
        handleRefreshgetProdectType()
        type.reloadAllComponents()
    }
    
    
    @objc private func handleRefreshgetBanner() {
        API_Favirot.Prodectbanner(prodectid: id ){(error: Error?, prodectBanner: [prodectImages]?) in
            if let prodectBanner = prodectBanner {
                self.prodectBanner = prodectBanner
                print("xxx\(self.prodectBanner)")
                self.bannerCollocationView.reloadData()
                self.page.numberOfPages =  prodectBanner.count
                self.page.currentPage = 0
                if prodectBanner.count != 0 {
                DispatchQueue.main.async {
                    self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
                }
                }
            }
        }
    }
    
    @objc func changeImage() {
        
        if counter < prodectBanner.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.bannerCollocationView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            page.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.bannerCollocationView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            page.currentPage = counter
            counter = 1
        }
        
    }
    
    func setUpView(){
        
        reate.rating = Double(singleItem?.Rate ?? 0)
        reate.settings.updateOnTouch = false
        totalRate.text = "\(singleItem?.total_rate_av ?? 0) "+"People review".localized
        
        if Int(singleItem?.SalesPrice ?? 0.0) != 0 {
            price.text = "\(singleItem?.SalesPrice ?? 0.0) $"
        }else{
            price.text = "\(singleItem?.OriginalPrice ?? 0.0) $"
        }
        
//        price.text = "\(singleItem?.OriginalPrice ?? 0.0) $"
        name.text = singleItem?.name
        type.text = singleItem?.caliber
        des.text = singleItem?.details
        if singleItem?.favorite == 0{
            favortBtn.setImage(UIImage(named: "favorite-heart-button"), for: UIControl.State.normal)
        }else {
            favortBtn.setImage(UIImage(named: "favorite-heart-button-1"), for: UIControl.State.normal)
        }
        
        if isFavorite == 1{
            favortBtn.setImage(UIImage(named: "favorite-heart-button-1"), for: UIControl.State.normal)
        }
    }
    
    func setColorToTextField(){
        TypeTF.leftViewMode = UITextField.ViewMode.always
        let myColorView = UIView(frame: CGRect(x: TypeTF.bounds.height , y: 0, width: TypeTF.bounds.height-10, height: TypeTF.bounds.height-10))
        myColorView.backgroundColor = hexStringToUIColor(hex: colorName)
        myColorView.layer.cornerRadius = myColorView.frame.width/2
        myColorView.clipsToBounds = true
        myColorView.layer.masksToBounds = true
        TypeTF.leftView = myColorView
    }
    
    @IBAction func addToFav(_ sender: Any) {
        API_Favirot.addFavProdect(prodectID: id) { (error, status, massage) in
            if status == true{
                if self.isFavorite == 0{
                    self.isFavorite = 1
                    self.favortBtn.setImage(UIImage(named: "favorite-heart-button-1"), for: .normal)
                }else{
                    self.isFavorite = 0
                    self.favortBtn.setImage(UIImage(named: "favorite-heart-button"), for: .normal)
                }
            }
        }
        
    }
    
    
    func handleRefreshFavProdect() {
        print("xxxxxxx")
        API_Home.carts{(error: Error?, cart: [cartData]?,taxes,delivery,price) in
            if let cart = cart {
                self.cart = cart
                print("sdsds\(self.cart)")
                if let tabItems = self.tabBarController?.tabBar.items {
                    let tabItem = tabItems[2]
                    tabItem.badgeValue = "\(cart.count)"
                }
                
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destenation = segue.destination as? imagesViewer{
            destenation.image = self.prodectBanner
            destenation.index = self.index
        }
    }
    
    @IBAction func addToCartBTN(_ sender: Any) {
        API_Favirot.addCartProdect(prodectID: id, colorID: colorId, size: size, carat: carat) { (error, massage) in
            self.showAlert(title: "Add to cart".localized, message: massage ?? "")
            self.handleRefreshFavProdect()
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 0xFF,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 0xFF,
            blue: CGFloat(rgbValue & 0x0000FF) / 0xFF,
            alpha: CGFloat(1.0)
        )
    }
}


extension pordectDitelsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prodectBanner.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = bannerCollocationView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? prodectbannerCell {
            let bannner = prodectBanner[indexPath.row]
            cell.configuerCell(prodect: bannner)
            return cell
        }else {
            return prodectbannerCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = bannerCollocationView.frame.size
        return CGSize(width: size.width, height: size.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.bannerCollocationView{
            self.index = indexPath.item
            performSegue(withIdentifier: "images", sender: nil)
        }
    }
}


extension pordectDitelsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return sizes.count
        }else {
            return types.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView.tag == 0{
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width, height: 60))
            let myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width , height: 60 ))
            myLabel.text = sizes[row].size
            myLabel.textAlignment = .center
            myView.addSubview(myLabel)
            return myView
            
        }else {
            let myView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width - 30, height: 60))
            let myColorView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            let myLabel = UILabel(frame: CGRect(x: pickerView.bounds.width/2 - 50, y: 0, width: pickerView.bounds.width - 90, height: 60 ))
            myLabel.text = types[row].carat
            myColorView.backgroundColor = hexStringToUIColor(hex: types[row].color)
            myColorView.layer.cornerRadius = myColorView.frame.width/2
            myColorView.clipsToBounds = true
            myColorView.layer.masksToBounds = true
            myView.addSubview(myLabel)
            myView.addSubview(myColorView)
            return myView
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0{
            size = sizes[row].size
            sizeTF.text = size
            sizess = sizes[row].id
            if Int(sizes[row].offer_price) != 0 {
                price.text = "\(sizes[row].offer_price) $"
            }else{
                price.text = "\(sizes[row].price) $"
            }
            //self.view.endEditing(false)
            
        }
        else{
            carat = types[row].carat
            TypeTF.text = carat
            colorId = types[row].id
            colorName = types[row].color
            handleRefreshgetProdectSize()
            setColorToTextField()
            //self.view.endEditing(false)
        }
    }
}
