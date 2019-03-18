//
//  CategoryViewController.swift
//  OnTheGo
//
//  Created by Ratnadeep on 3/2/19.
//  Copyright © 2019 R. All rights reserved.
//

import UIKit

enum Category: String,CaseIterable {
    case jobSeeker = "1"
    case employer = "2"
    case agency = "3"
}
class CategoryViewController: UIViewController {

    @IBOutlet weak var jobSeekerBtn: UIButton!
    @IBOutlet weak var employerBtn: UIButton!
    @IBOutlet weak var agencyBtn: UIButton!
    @IBOutlet weak var submitBtn:UIButton!
    var selectedCategory: Category?
    var reponseData: [String: Any]?
    var utilityMView = UtilityMessage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func jobSeekerBtnAction(_ sender: UIButton) {
        unselectCategory()
        selectedCategory = .jobSeeker
        self.jobSeekerBtn.setImage(UIImage(named: "radio-on-button"), for: .normal)
    }
    @IBAction func employerBtnAction(_ sender: UIButton) {
        unselectCategory()
          selectedCategory = .employer
        self.employerBtn.setImage(UIImage(named: "radio-on-button"), for: .normal)
        
        
    }
    @IBAction func agencyBtnAction(_ sender: UIButton) {
        unselectCategory()
          selectedCategory = .agency
        self.agencyBtn.setImage(UIImage(named: "radio-on-button"), for: .normal)
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
    }
    
    func unselectCategory() {
        self.jobSeekerBtn.setImage(UIImage(named: "radio-off-button"), for: .normal)
        self.employerBtn.setImage(UIImage(named: "radio-off-button"), for: .normal)
        self.agencyBtn.setImage(UIImage(named: "radio-off-button"), for: .normal)
        
    }
    @IBAction func sumbitBtnAction(_ sender: UIButton) {
        
        guard let selCategory = selectedCategory else {
            return
        }
        guard let passData = reponseData else {
            
            return
        }
        
        let parameters:[String: String] = ["id":"\(String(describing: passData["id"]!))","category":"\(selCategory.rawValue)","token":"\(String(describing: passData["token"]!))"]
        
        NetworkManager().categoryAPI(parameters) { (data, error) in
            if error != nil {
                print("error \(String(describing: error))")
                return
            }
            let cat =  data?["category"] as! String
            self.utilityMView.openDashboardCategory(cat, view: self)
        }
    }

}
