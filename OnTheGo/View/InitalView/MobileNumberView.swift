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
    func didConfirmMobile(_ mobileNumber: String)
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
        self.delegate.didConfirmMobile(mobilenumber)

        /*
        NetworkManager.shareInstant.postrequest(.sendOTP, parameter: ["phone":"\(mobilenumber)"]) { (data, error) in
            if error == nil {
                print("data : \(String(describing: data))")
//                self.sessionIDStr = data!["sessionID"] as? String
//                let indexStartOfText = self.sessionIDStr .index(self.sessionIDStr .startIndex, offsetBy: 1) // 3
//                let indexEndOfText = self.sessionIDStr .index(self.sessionIDStr .endIndex, offsetBy: -1)    // 8
//                self.sessionIDStr = String(self.sessionIDStr[indexStartOfText..<indexEndOfText])
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    
                }
            }else{
                
            }
        }
        */
    
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










