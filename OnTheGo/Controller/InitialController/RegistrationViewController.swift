//
//  LoginViewController.swift
//  OnTheGo
//
//  Created by Ratnadeep on 12/5/18.
//  Copyright © 2018 R. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol RegistrationViewControllerDelegate: NSObjectProtocol {
    func didCancelLogin()
}
class RegistrationViewController: UIViewController {

    @IBOutlet weak var mobileViewHzCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginView: MobileNumberView!
    @IBOutlet weak var otpConfirmationView: OTPConfirmationView!
    @IBOutlet weak var createPasswordView: CreatePasswordView!
    @IBOutlet weak var otpXConstraint: NSLayoutConstraint!
    @IBOutlet weak var passwordXConstraint: NSLayoutConstraint!
    weak var delegate: RegistrationViewControllerDelegate!
    
    
    var mobileNumber: String!
    var sessionIDStr: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginView.delegate = self
        self.otpConfirmationView.delegate = self
        self.createPasswordView.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
            self.moveLoginViewRightToLeft()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func moveLoginViewRightToLeft () {
        self.otpXConstraint.constant = 500.0
        self.mobileViewHzCenterConstraint.constant = 500.0
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: Double(0.5), animations: {
            self.mobileViewHzCenterConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    
    func otpReg(_ mobilenumber: String) {
        DispatchQueue.main.async {
//            SVProgressHUD.dismiss()
            self.moveOTPViewRightToLeft()
        }

        return
            
//        SVProgressHUD.show()
//        self.mobileNumber = mobilenumber
//
//        NetworkManager.shareInstant.postrequest(.sendOTP, parameter: ["phone":"\(mobilenumber)"]) { (data, error) in
//            if error == nil {
//                print("data : \(String(describing: data))")
//                self.sessionIDStr = data!["sessionID"] as? String
//
//                let indexStartOfText = self.sessionIDStr .index(self.sessionIDStr .startIndex, offsetBy: 1) // 3
//                let indexEndOfText = self.sessionIDStr .index(self.sessionIDStr .endIndex, offsetBy: -1)    // 8
//
//                self.sessionIDStr = String(self.sessionIDStr[indexStartOfText..<indexEndOfText])
//                DispatchQueue.main.async {
//                    SVProgressHUD.dismiss()
//                    self.moveOTPViewRightToLeft()
//                }
//            }else{
//
//            }
//        }
    }
    
  
    
    func moveOTPViewRightToLeft() {
        self.mobileViewHzCenterConstraint.constant = -500.0
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: Double(0.5), animations: {
            self.otpXConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func moveCreateRightToLeft() {
        self.otpXConstraint.constant = -500
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: Double(0.5), animations: {
            self.passwordXConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
}

extension RegistrationViewController: MobileNumberViewDelegate {
    func didCancelLogin() {
        self.dismiss(animated: true, completion: nil)
        self.delegate.didCancelLogin()

    }
    func didConfirmMobile(_ mobileNumber: String) {
        
        otpReg(mobileNumber)
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
        self.moveCreateRightToLeft()
        
        return
        
        
        let parameters = ["session":self.sessionIDStr!,"phone":self.mobileNumber!, "otp":otpStr]
        NetworkManager.shareInstant.postrequest(.otpVerify, parameter: parameters) { (data, error) in
            if error == nil {
                print("otpVerify data : \(String(describing: data))")
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self.moveCreateRightToLeft()
                }
            }else {
            }
        }
}
}

extension RegistrationViewController:CreatePasswordDelegate {
    func didConfirm(){
        let categoryController: CategoryViewController =  storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        self.present(categoryController, animated: true, completion: nil)
    }
    func didPasswordCancel(){
        self.dismiss(animated: true, completion: nil)
        self.delegate.didCancelLogin()
    }
}
