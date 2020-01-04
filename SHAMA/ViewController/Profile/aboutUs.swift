//
//  aboutUs.swift
//  SHAMA
//
//  Created by Tariq on 12/9/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class aboutUs: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var descriptionLb: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getAboutUS()
        
    }
    
    func getAboutUS(){
        API_Profile.aboutUs { (error, status, image, title, desc) in
            self.titleLb.text = title
            self.descriptionLb.text = desc
//            self.imageView.image = UIImage(named: "3")
//            let s = ("\(URLs.mainImage)\(image ?? "")")
//            let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
//            let encodedURL = NSURL(string: encodedLink!)! as URL
//            self.imageView.kf.indicatorType = .activity
//            if let url = URL(string: "\(encodedURL)") {
//                print("g\(url)")
//                self.imageView.kf.setImage(with: url)
//            }
        }
    }

}
