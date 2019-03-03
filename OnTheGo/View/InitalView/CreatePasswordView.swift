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
    @IBAction func confirmBtnAction(_ sender: UIButton) {
        self.delegate.didConfirm()
    }
    
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        self.delegate.didPasswordCancel()
    }
}
