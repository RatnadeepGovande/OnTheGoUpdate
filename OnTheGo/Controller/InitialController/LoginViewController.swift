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
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginContentHzCenterConstraint: NSLayoutConstraint!
    var utilityMessage = UtilityMessage()
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
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        guard let txt = usernameTxt.text, Utility().isVaildNumber(txt) else {
            print("txt not....")
            return
        }
        guard passwordTxt.text.nilIfEmpty != nil else {
            print("please enter password")
            return
        }
        
        NetworkManager().loginAPI(mobileNumber: txt) { (data, error) in
            if error != nil {
                print("error \(String(describing: error))")
                
                DispatchQueue.main.async {
                    self.utilityMessage.alertViewWith("Message", "\(String(describing:error))", self)
                }
                return
            }
            
            var dataR = data?["data"] as! [String: Any]
            
            if dataR["token"] == nil {
                DispatchQueue.main.async {
                    self.utilityMessage.alertViewWith("Message", "User not registered", self)
                }
                return
            }
            if dataR["category"] is NSNull   {
                DispatchQueue.main.async {
                    let categoryController: CategoryViewController =  self.storyboard?.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
                    categoryController.reponseData = dataR
                    self.present(categoryController, animated: true, completion: nil)
                }
                return
            }
            self.utilityMessage.openDashboardCategory(dataR["category"] as! String, view: self)
        }
    }
    
    @IBAction func cancelBtn(_ sender: UIButton) {
        self.delegate?.didPressCancelBtnLogView(self)
    }
}
