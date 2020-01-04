//
//  editProfileVC.swift
//  SHAMA
//
//  Created by Farido on 8/20/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class editProfileVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProifle()
    }
    
    func getProifle(){
        self.spiner.isHidden = false
        self.spiner.startAnimating()
        API_Profile.profileData { (error, status, profileData) in
            self.nameTF.text = profileData?[0].name ?? ""
            self.emailTF.text = profileData?[0].email ?? ""
            self.phone.text = profileData?[0].phone ?? ""
            self.spiner.isHidden = true
            self.spiner.stopAnimating()
        }
    }
    @IBAction func editBTN(_ sender: Any) {
        self.spiner.isHidden = false
        self.spiner.startAnimating()
        API_Profile.editProfile(name: nameTF.text ?? "", email: emailTF.text ?? "", phone: phone.text ?? "") { (error, message) in
            self.showAlert(title: "Edit".localized, message: message ?? "")
            self.spiner.isHidden = true
            self.spiner.stopAnimating()
        }
    }
    
}
