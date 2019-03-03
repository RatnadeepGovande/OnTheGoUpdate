//
//  LoginViewController.swift
//  OnTheGo
//
//  Created by Ratnadeep on 3/2/19.
//  Copyright © 2019 R. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: NSObjectProtocol {
    func didPressCancelBtnLogView(_ viewController: UIViewController)
}

class LoginViewController: UIViewController {
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginContentHzCenterConstraint: NSLayoutConstraint!
    weak var delegate:LoginViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
            self.moveLoginViewRightToLeft()
        }
    }
    
    func moveLoginViewRightToLeft () {
        
        UIView.animate(withDuration: Double(0.5), animations: {
            self.loginContentHzCenterConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.delegate?.didPressCancelBtnLogView(self)
    }
}
