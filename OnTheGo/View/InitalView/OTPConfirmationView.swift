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
    var mobileNumber: String?
    
    @IBAction func proceedBtnAction(_ sender: UIButton) {
        
        
        self.delegate.didOTPProceed(otpTxt.text!)
    }
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.delegate.didOTPCancelAction()
    }
}
