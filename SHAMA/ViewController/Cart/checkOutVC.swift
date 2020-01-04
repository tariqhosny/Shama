//
//  checkOutVC.swift
//  SHAMA
//
//  Created by Farido on 8/19/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class checkOutVC: UIViewController {

    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var cashSwitch: UISwitch!
    @IBOutlet weak var paymentSwitch: UISwitch!
    
    var totalPrice = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    @IBAction func cashSwitshPressed(_ sender: UISwitch) {
        if cashSwitch.isOn{
            paymentSwitch.setOn(false, animated: true)
        }else{
            paymentSwitch.setOn(true, animated: true)
        }
    }
    
    @IBAction func paymentSwitchPressed(_ sender: UISwitch) {
        if paymentSwitch.isOn{
            cashSwitch.setOn(false, animated: true)
        }else{
            cashSwitch.setOn(true, animated: true)
        }
    }
    
    @IBAction func checkOUtBTN(_ sender: Any) {
        
    guard let phone = phoneTF.text, let address = addressTF.text, let city = cityTF.text else {return}
        if (phone.isEmpty == true || address.isEmpty == true || city.isEmpty == true){
            self.displayErrors(errorText: "Empty Fields".localized)
        }else {
            if self.cashSwitch.isOn{
                API_Favirot.createOrders(phone: phoneTF.text ?? "", totalPrice: totalPrice, address: addressTF.text ?? "", city: cityTF.text ?? "", paymentMethod: 1) { (error, status,massage) in
                    if status == true{
                        let alert = UIAlertController(title: "Checkout".localized, message: massage ?? "", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Ok".localized, style: UIAlertAction.Style.default,  handler: { action in
                                helper.restartApp()
                            }))
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        self.showAlert(title: "Checkout".localized, message: massage ?? "")
                    }
                }
            }else if self.paymentSwitch.isOn{
                self.performSegue(withIdentifier: "payment".localized, sender: nil)
            }else if !self.cashSwitch.isOn && !self.paymentSwitch.isOn{
                let alert = UIAlertController(title: "Faild".localized, message: "Please select the payment method".localized, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    func displayErrors (errorText: String){
        let alert = UIAlertController.init(title: "Error".localized, message: errorText, preferredStyle: .alert)
        let dismissAction = UIAlertAction.init(title: "Dismiss".localized, style: .default, handler: nil)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destenation = segue.destination as? paymentWebView{
            destenation.totalPrice = self.totalPrice
            destenation.city = self.cityTF.text ?? ""
            destenation.phone = self.phoneTF.text ?? ""
            destenation.address = self.addressTF.text ?? ""
        }
    }
}
