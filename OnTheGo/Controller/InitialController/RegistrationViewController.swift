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
    
    
    func otpReg(_ logData: [String:Any]) {
        DispatchQueue.main.async {
            self.otpConfirmationView.logReponseData = logData
            self.moveOTPViewRightToLeft()
        }
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


