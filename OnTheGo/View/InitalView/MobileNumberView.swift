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
    func didConfirmMobile(_ data:[String:String])
}

class MobileNumberView: UIView {
    weak var delegate:MobileNumberViewDelegate!
    @IBOutlet weak var mobileTxt: UITextField!
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        guard let txt = mobileTxt.text, isVaildNumber(txt) else {
            print("txt not....")
            return
        }
        print("\(txt)")
        calld(txt)        
    }
    
    func calld(_ mobilenumber: String){
        
        SVProgressHUD.show()
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
        NetworkManager().loginAPI(mobileNumber: mobilenumber) { (data, error) in
            if error != nil {
                print("Error : \(String(describing: error))")
            }
            
            DispatchQueue.main.async {
                print("\(String(describing: data!["data"]))")
                var dataR : [String:Any] =  data!["data"] as! [String:Any]
                
                dataR["mobile"] = mobilenumber
                print(dataR["request_id"]!)
                
                self.delegate.didConfirmMobile(dataR as! [String : String])
            }
        }
    }
    
    func isVaildNumber(_ number: String)->Bool {
        if (number.count < 10) {
            return false
        }
        
        let range = number.rangeOfCharacter(from: .whitespaces)
        if let range = range {
            return false
        }
        return true
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.delegate.didCancelLogin()
    }
}










