//
//  favirotCell.swift
//  SHAMA
//
//  Created by Farido on 8/6/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class favirotCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var fivart: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var orginalPrice: UILabel!
    @IBOutlet weak var priceView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        
    }
    
    override var frame: CGRect {
      get {
          return super.frame
      }
      set (newFrame) {
          var frame =  newFrame
          frame.origin.y += 4
          frame.size.height -= 2 * 5
          super.frame = frame
      }
    }
    
    func configuerCell(prodect: bestDimond) {
        
        if Int(prodect.SalesPrice) != 0 {
            price.text = "\(prodect.SalesPrice) $"
            orginalPrice.text = "\(prodect.OriginalPrice)$"
            orginalPrice.isHidden = false
            priceView.isHidden = false
        }else{
            orginalPrice.isHidden = true
            priceView.isHidden = true
            price.text = "\(prodect.OriginalPrice) $"
        }
        
        fivart.image = UIImage(named: "favorite-heart-button-1")
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

