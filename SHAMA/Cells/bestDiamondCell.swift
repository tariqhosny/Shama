//
//  bestDiamondCell.swift
//  SHAMA
//
//  Created by Farido on 8/5/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class bestDiamondCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var offores: UILabel!
    @IBOutlet weak var fivart: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var orginalPrice: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var offerView: UIView!
    
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
    }
    
    func configuerCell(prodect: bestDimond) {
        if prodect.favorite == 0{
            fivart.image = UIImage(named: "favorite-heart-button")
        }else if prodect.favorite == 1{
            fivart.image = UIImage(named: "favorite-heart-button-1")
        }
        
        if Int(prodect.SalesPrice) != 0 {
            let offer = (Int(prodect.OriginalPrice) - (Int(prodect.SalesPrice)))
            let offerPercent = offer * 100 / (Int(prodect.OriginalPrice))
            offores.text = "\(offerPercent) % "+"OFFER".localized
            price.text = "\(prodect.SalesPrice) $"
            orginalPrice.text = "\(prodect.OriginalPrice)$"
            offores.isHidden = false
            offerView.isHidden = false
            orginalPrice.isHidden = false
            priceView.isHidden = false
        }else{
            offores.isHidden = true
            offerView.isHidden = true
            orginalPrice.isHidden = true
            priceView.isHidden = true
            price.text = "\(prodect.OriginalPrice) $"
        }
        
        name.text = prodect.name
        size.text = prodect.caliber
        img.image = UIImage(named: "3")
        let s = ("\(URLs.mainImage)\(prodect.photo)")
        let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        img.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            print("g\(url)")
            img.kf.setImage(with: url)
        }
    }
}

