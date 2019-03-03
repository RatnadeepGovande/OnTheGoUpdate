//
//  CategoryViewController.swift
//  OnTheGo
//
//  Created by Ratnadeep on 3/2/19.
//  Copyright © 2019 R. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sumbitBtnAction(_ sender: UIButton) {
        let jobseekerStoryboard: UIStoryboard = UIStoryboard.init(name: "JobSeeker", bundle: nil)
        let jobseekerTabBarController: JobSeekerTabBarController = jobseekerStoryboard.instantiateViewController(withIdentifier: "JobSeekerTabBarController") as! JobSeekerTabBarController
        self.present(jobseekerTabBarController, animated: true, completion: nil)
    }

}
