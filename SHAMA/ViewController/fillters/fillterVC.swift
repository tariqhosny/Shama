//
//  fillterVC.swift
//  SHAMA
//
//  Created by Farido on 8/17/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class fillterVC: UIViewController {
    
    @IBOutlet weak var forWomenBtn: UIButton!
    @IBOutlet weak var formenBten: UIButton!
    @IBOutlet weak var styleCollectionView: UICollectionView!
    @IBOutlet weak var mainTF: UITextField!
    @IBOutlet weak var maxTF: UITextField!
    @IBOutlet weak var ColorCollectionView: UICollectionView!
    
    
    var men = 0
    var woman = 0
    var typeId = 0
    var caratId = 0
    
    
    var types = [prodectTypeGold]()
    var colors = [allTypes]()
    var prodectStyle = [prodectStylessss]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleCollectionView.dataSource = self
        styleCollectionView.delegate = self
        ColorCollectionView.dataSource = self
        ColorCollectionView.delegate = self
        handleRefreshgetStyle()
        handleRefreshgetColors()
        
    }
    
    @objc private func handleRefreshgetStyle() {
        API_Favirot.prodectStyles{(error: Error?, prodectStyle: [prodectStylessss]?) in
            if let prodectStyle = prodectStyle {
                self.prodectStyle = prodectStyle
                print("xxx\(self.prodectStyle)")
                self.styleCollectionView.reloadData()
            }
        }
    }
    
    @objc private func handleRefreshgetColors() {
        API_Home.allTypesApi { (error, color: [allTypes]?) in
            if let colors = color {
                self.colors = colors
                self.ColorCollectionView.reloadData()
            }
        }
    }
    
    @IBAction func forwomenAction(_ sender: Any) {
        men = 0
        woman = 1
        forWomenBtn.setImage(UIImage(named: "Group 233"), for: .normal)
        formenBten.setImage(UIImage(named: "Group 232"), for: .normal)
    }
    
    @IBAction func formanActionBTN(_ sender: Any) {
        men = 1
        woman = 0
        forWomenBtn.setImage(UIImage(named: "Group 125"), for: .normal)
        formenBten.setImage(UIImage(named: "Group 290"), for: .normal)
    }
    
    @IBAction func filterBTN(_ sender: Any) {
        performSegue(withIdentifier: "suge", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? filterResultVC{
            destaiantion.maxPrice = maxTF.text ?? ""
            destaiantion.minPrice = mainTF.text ?? ""
            destaiantion.men = men
            destaiantion.woman = woman
            destaiantion.typeId = typeId
            destaiantion.caratId = caratId
        }
    }
    
}


extension fillterVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ColorCollectionView{
            return colors.count
        }else{
            return prodectStyle.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == ColorCollectionView{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productColorCell", for: indexPath) as? productColorCell {
                let bannner = colors[indexPath.row]
                cell.configureCell(product: bannner)
                return cell
            }else {
                return styleCell()
            }
        }else{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? styleCell {
                let bannner = prodectStyle[indexPath.row]
                cell.configuerCell(prodect: bannner)
                return cell
            }else {
                return styleCell()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == ColorCollectionView{
            return CGSize(width: 50, height: 50)
        }else{
            let size = styleCollectionView.frame.size
            return CGSize(width: (size.width)/3-20, height: size.height/2-10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == ColorCollectionView{
            self.typeId = colors[indexPath.row].id
        }else{
            self.caratId = prodectStyle[indexPath.row].id
        }
    }
}
