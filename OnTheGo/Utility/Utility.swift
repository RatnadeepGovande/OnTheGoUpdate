//
//  Utility.swift
//  OnTheGo
//
//  Created by Ratnadeep on 3/16/19.
//  Copyright © 2019 R. All rights reserved.
//

import Foundation
import UIKit

struct Utility {
    
    func isVaildNumber(_ number: String) -> Bool {
        if (number.count < 10) {
            return false
        }
        
        let range = number.rangeOfCharacter(from: .whitespaces)
        if let range = range {
            return false
        }
        return true
    }
}


class UtilityMessage : NSObject {
    
    func alertViewWith(_ title: String = "Message", _ message:String, _ view: UIViewController) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        view.present(ac, animated: true, completion: {
            
        })
    }
    
    
    func openDashboardCategory(_ category: String, view: UIViewController) {
        switch category {
        case "1":
            DispatchQueue.main.async {
                let jobseekerStoryboard: UIStoryboard = UIStoryboard.init(name: "JobSeeker", bundle: nil)
                let jobseekerTabBarController: JobSeekerTabBarController = jobseekerStoryboard.instantiateViewController(withIdentifier: "JobSeekerTabBarController") as! JobSeekerTabBarController
                view.present(jobseekerTabBarController, animated: true, completion: nil)
            }
            break
        case "2":
            break
        case "3":
            break
        default:
            break
        }
    }
}
