//
//  MobileNumberView.swift
//  OnTheGo
//
//  Created by philips on 12/6/18.
//  Copyright © 2018 R. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol MobileNumberViewDelegate: NSObjectProtocol {
    func didCancelLogin()
    func didConfirmMobile(_ data:[String:Any]?, error:String?)
}

class MobileNumberView: UIView {
    weak var delegate:MobileNumberViewDelegate!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        guard let txt = mobileTxt.text, Utility().isVaildNumber(txt) else {
            print("txt not....")
            return
        }
        print("\(txt)")
        calld(txt)        
    }
    
    func calld(_ mobilenumber: String){
        
        SVProgressHUD.show()
       
        NetworkManager().loginAPI(mobileNumber: mobilenumber) { (data, error) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            if error != nil {
                print("Error : \(String(describing: error))")
                return
            }
            DispatchQueue.main.async {
                print("\(String(describing: data!["data"]))")
                var dataR : [String:Any] =  data!["data"] as! [String:Any]
                if dataR["token"] != nil {
                    print("user already exists..")
                    self.delegate.didConfirmMobile(dataR, error: "User already exists.")
                    return
                }
                dataR["mobile"] = mobilenumber
                print(dataR["request_id"]!)
                self.delegate.didConfirmMobile(dataR, error: nil)
            }
        }
    }

    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.delegate.didCancelLogin()
    }
}


extension RegistrationViewController: MobileNumberViewDelegate {
    func didConfirmMobile(_ data: [String : Any]?, error: String?) {
        if error != nil {
            self.messageViewPopView(error!)
        }else{
             otpReg(data!)
        }
    }
    
    func didCancelLogin() {
        self.dismiss(animated: true, completion: nil)
        self.delegate.didCancelLogin()
    }
   
    func messageViewPopView(_ message: String) {
        let alertController: UIAlertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}



