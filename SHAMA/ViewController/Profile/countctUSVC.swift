//
//  countctUSVC.swift
//  SHAMA
//
//  Created by Farido on 8/20/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class countctUSVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var message: roundedTextView!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        spiner.isHidden = true
        super.viewDidLoad()
    }

    @IBAction func sendMsgTV(_ sender: Any) {
        self.spiner.isHidden = false
        self.spiner.startAnimating()
        API_Profile.counectUS(name: nameTF.text ?? "", email: emailTF.text ?? "", phone: phone.text ?? "", message: message.text ?? "") { (error, message) in
            self.showAlert(title: "Contact us".localized, message: message ?? "")
            self.spiner.isHidden = true
            self.spiner.stopAnimating()
        }
    }
}
