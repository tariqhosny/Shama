//
//  loginVC.swift
//  SHAMA
//
//  Created by Farido on 8/1/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class loginVC: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spiner.isHidden = true
        
        
    }
    
    @IBAction func loginBTN(_ sender: Any) {
        
        guard let emails = email.text, !emails.isEmpty else {
            let messages = "Please enter your email".localized
            let title = "Login".localized
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard isValidEmail(testStr: email.text ?? "") == true else {
            let messages = "Email not correct".localized
            let title = "Login Failed".localized
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let passwords = password.text, !passwords.isEmpty else {
            let messages = "Please enter your password".localized
            let title = "Login".localized
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard password.text?.count ?? 0 >= 6 else {
            let messages = "The password must be at least 6 characters".localized
            let title = "Register".localized
            self.showAlert(title: title, message: messages)
            return
        }
        
        self.spiner.startAnimating()
        self.spiner.isHidden = false
        
        API_Auth.login(email: email.text ?? "", password: password.text ?? ""){ (error, success, data, status, message) in
            if success {
                if data == nil {
                    print("success")
                }else {
                    self.showAlert(title: "Login Failed".localized, message: "\(message ?? "")")
                    self.password.text = ""
                }
            }else {
                self.showAlert(title: "Login Failed".localized, message: "\(message ?? "")")
                self.password.text = ""
            }
            
            self.spiner.stopAnimating()
            self.spiner.isHidden = true
            
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
