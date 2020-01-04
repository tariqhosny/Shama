//
//  signUpVC.swift
//  SHAMA
//
//  Created by Farido on 8/1/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class signUpVC: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConform: UITextField!
    @IBOutlet weak var spenier: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spenier.isHidden = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItems = []
        self.navigationItem.hidesBackButton = true
    }
    
    
    @IBAction func loginBackBTN(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as! loginVC
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: false, completion: nil)
        
        
    }
    
    @IBAction func signUPBTN(_ sender: Any) {
        
        guard let names = name.text, !names.isEmpty else {
            let messages = "Please enter your name".localized
            let title = "Register".localized
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let emails = email.text, !emails.isEmpty else {
            let messages = "Please enter your email".localized
            let title = "Register".localized
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let phones = phone.text, !phones.isEmpty else {
            let messages = "Please enter your phone".localized
            let title = "Register".localized
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let passwords = password.text, !passwords.isEmpty else {
            let messages = "Please enter your password".localized
            let title = "Register".localized
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let passwordConforms = passwordConform.text, !passwordConforms.isEmpty else {
            let messages = "Please confirm password".localized
            let title = "Register".localized
            self.showAlert(title: title, message: messages)
            return
        }
        
        
        guard password.text?.count ?? 0 >= 6 else {
            let messages = "The password must be at least 6 characters".localized
            let title = "Register".localized
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard passwordConform.text?.count ?? 0 >= 6 else {
            let messages = "The password must be at least 6 characters".localized
            let title = "Register".localized
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard password.text == passwordConform.text else {
            let messages = "Password and confirm password must be the same".localized
            let title = "Register".localized
            self.showAlert(title: title, message: messages)
            return
        }
        
        
        guard isValidInput(Input: name.text!) == true else {
            self.showAlert(title: "Register".localized, message: "Name not correct".localized)
            return
        }
        
        
        guard isValidEmail(testStr: email.text ?? "") == true else {
            let messages = "Email not correct".localized
            let title = "Register Failed".localized
            self.showAlert(title: title, message: messages)
            return
        }
        
        self.spenier.startAnimating()
        self.spenier.isHidden = false
        
        API_Auth.register(name: name.text ?? "", email: email.text ?? "", password: password.text ?? "", phone: phone.text ?? "") { (error, success, data, status, message) in
            if success {
                if data == nil {
                    print("success")
                }else {
                    self.showAlert(title: "Login Failed".localized, message: "\(data ?? "")")
                    self.password.text = ""
                    self.passwordConform.text = ""
                }
                //
            }else {
                self.showAlert(title: "Login Failed".localized, message: "\(data ?? "")")
                self.password.text = ""
                self.passwordConform.text = ""
            }
            
            self.spenier.stopAnimating()
            self.spenier.isHidden = true
            
        }
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func isValidInput(Input:String) -> Bool {
        let myCharSet=CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ أ إ  ض ص ث ق ف غ ع ه خ ح  ج د ش ي ب ل ا ت ن م ك  ط ئ ء ؤ ر لا ى ة و ز ظ")
        let output: String = Input.trimmingCharacters(in: myCharSet.inverted)
        let isValid: Bool = (Input == output)
        print("\(isValid)")
        
        return isValid
    }
}
