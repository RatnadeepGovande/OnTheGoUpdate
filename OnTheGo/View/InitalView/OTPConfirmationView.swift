//
//  OTPConfirmationView.swift
//  OnTheGo
//
//  Created by Ratnadeep on 3/2/19.
//  Copyright © 2019 R. All rights reserved.
//

import UIKit

protocol OTPConfirmationDelegate: NSObjectProtocol {
    func didOTPCancelAction()
    func didOTPProceed(_ otpStr: String)
}

class OTPConfirmationView: UIView {
    weak var delegate: OTPConfirmationDelegate!
    @IBOutlet weak var otpTxt: UITextField!
    var logReponseData: [String:String]?
    
    
    @IBAction func proceedBtnAction(_ sender: UIButton) {
        
        logReponseData?["otp"] = otpTxt.text!
        NetworkManager().otpVerificationAPI(logReponseData!) { (data, error) in
            
            if error != nil {
                print("\(String(describing: error))")
                return
            }
            self.delegate.didOTPProceed(self.otpTxt.text!)
        }
    }
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.delegate.didOTPCancelAction()
    }
}
