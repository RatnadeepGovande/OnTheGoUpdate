//
//  OTPConfirmationView.swift
//  OnTheGo
//
//  Created by Ratnadeep on 3/2/19.
//  Copyright © 2019 R. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol OTPConfirmationDelegate: NSObjectProtocol {
    func didOTPCancelAction()
    func didOTPProceed(_ otpStr: String)
}

class OTPConfirmationView: UIView {
    weak var delegate: OTPConfirmationDelegate!
    @IBOutlet weak var otpTxt: UITextField!
    var logReponseData: [String:Any]?
    
    
    @IBAction func proceedBtnAction(_ sender: UIButton) {
        
        logReponseData?["otp"] = otpTxt.text!
        NetworkManager().otpVerificationAPI(logReponseData! as! [String:String]) { (data, error) in
            if error != nil {
                print("\(String(describing: error))")
                return
            }
            DispatchQueue.main.async {
                self.delegate.didOTPProceed(self.otpTxt.text!)
            }
        }
    }
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.delegate.didOTPCancelAction()
    }
}

extension RegistrationViewController: OTPConfirmationDelegate {
    func didOTPCancelAction(){
        self.dismiss(animated: true, completion: nil)
        self.delegate.didCancelLogin()
    }
    func didOTPProceed(_ otpStr: String){
        SVProgressHUD.show()
        SVProgressHUD.dismiss()
        createPasswordView.logReponseData  = otpConfirmationView.logReponseData
        self.moveCreateRightToLeft()
    }
}
