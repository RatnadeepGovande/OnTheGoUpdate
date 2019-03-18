//
//  CreatePasswordView.swift
//  OnTheGo
//
//  Created by Ratnadeep on 3/2/19.
//  Copyright © 2019 R. All rights reserved.
//

import UIKit

protocol CreatePasswordDelegate: NSObjectProtocol {
    func didConfirm()
    func didPasswordCancel()
}

class CreatePasswordView: UIView {
    
    weak var delegate:CreatePasswordDelegate!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confrimPasswordTxt: UITextField!
    
    var logReponseData: [String:Any]?
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        
        guard let password = passwordTxt.text.nilIfEmpty else {
            print("please enter password")
            return
        }
        if confrimPasswordTxt.text != password {
            print("ConfrimPassword not same")
            return
        }
        
        
        self.logReponseData?["password"] = password
        NetworkManager().createPassword( self.logReponseData! as! [String : String]) { (data, error) in
            if error != nil {
                print("error \(String(describing: error))")
                return
            }
            print("data \(String(describing: data))")
            DispatchQueue.main.async {
                self.delegate.didConfirm()
            }
        }
    }

    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.delegate.didPasswordCancel()
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

extension Optional where Wrapped == String {
    var nilIfEmpty: String? {
        guard let strongSelf = self else {
            return nil
        }
        return strongSelf.isEmpty ? nil : strongSelf
    }
}
