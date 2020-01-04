//
//  profileVC.swift
//  SHAMA
//
//  Created by Farido on 8/19/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import MOLH

class profileVC: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var payed: UILabel!
    @IBOutlet weak var product: UILabel!
    @IBOutlet weak var orders: UILabel!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        spiner.isHidden = true
        getProifle()
    }
    override func viewWillAppear(_ animated: Bool) {
        getProifle()
    }
    
    func getProifle(){
        self.spiner.isHidden = false
        self.spiner.startAnimating()
        API_Profile.profileData { (error, status, profileData) in
            self.name.text = profileData?[0].name ?? ""
            self.email.text = profileData?[0].email ?? ""
            self.number.text = profileData?[0].phone ?? ""
            self.orders.text = "\(profileData?[0].count_orders ?? "") "+"Orders".localized
            self.payed.text = "\(profileData?[0].total_amount ?? 0)$ "+"Payed".localized
            self.product.text = "\(profileData?[0].count_product ?? 0) "+"Products".localized
            self.spiner.isHidden = true
            self.spiner.stopAnimating()
        }    }
    
    @IBAction func language(_ sender: UIButton) {
        let alert = UIAlertController(title: NSLocalizedString("Select Language", comment: ""), message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "English", style: .destructive, handler: { (action: UIAlertAction) in
            MOLH.setLanguageTo("en")
            MOLH.reset()
        }))
        alert.addAction(UIAlertAction(title: "עברית", style: .destructive, handler: { (action: UIAlertAction) in
            MOLH.setLanguageTo("he")
            MOLH.reset()
        }))
        alert.addAction(UIAlertAction(title: "عربى", style: .destructive, handler: { (action: UIAlertAction) in
            MOLH.setLanguageTo("ar")
            MOLH.reset()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func logoutBtn(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to log out?".localized, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (action: UIAlertAction) in
            helper.dleteAPIToken()
        }))
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
