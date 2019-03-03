//
//  MainViewController.swift
//  OnTheGo
//
//  Created by philips on 12/5/18.
//  Copyright © 2018 R. All rights reserved.
//
import SideMenu
import UIKit
import AVKit
import AVFoundation

class MainViewController: UIViewController {
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    
    @IBOutlet weak var bg_image: UIImageView!
    @IBOutlet weak var loginContainView: UIView!
    @IBOutlet weak var LoginContainXConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        backgroundVideo()
        
        self.setupSideMenu()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        playerLayer?.frame = CGRect(x: 0, y:0, width: self.view.bounds.width, height: self.view.bounds.height)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    

    func moveLogInViewRightToLeft() {
    
        UIView.animate(withDuration: Double(0.5), animations: {
            self.LoginContainXConstraint.constant = -500.0
            self.view.layoutIfNeeded()
        })
    }
    fileprivate func backgroundVideo () {
        
        guard let path = Bundle.main.path(forResource: "bg_video", ofType: "mp4") else {
            print("Video not available")
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        playerLayer = AVPlayerLayer(player: player)
        NotificationCenter.default.addObserver(self, selector: #selector(endVideo), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        self.player?.isMuted = true
        playerLayer?.frame = self.view.bounds
        do {
             try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: .default, options: .defaultToSpeaker)
        }catch {
            
        }
       
        self.bg_image.layer.addSublayer(playerLayer!)
        player?.play()
    }
    
    @objc func endVideo() {
        self.player?.seek(to: CMTime.zero)

        player?.play()
    }
    fileprivate func setupSideMenu () {
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        SideMenuManager.default.menuAnimationBackgroundColor =  UIColor(patternImage: UIImage(named: "background_sidemenu")!)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @IBAction func signupBtn(_ sender: UIButton) {
        let signupController: RegistrationViewController = storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
        signupController.modalTransitionStyle = .crossDissolve
        signupController.modalPresentationStyle = .overCurrentContext
        signupController.delegate = self
        DispatchQueue.main.async {
            self.present(signupController, animated: true) {
                self.moveLogInViewRightToLeft()
            }
        }
       
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        let loginController :   LoginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginController.modalTransitionStyle = .crossDissolve
        loginController.modalPresentationStyle = .overCurrentContext
        loginController.delegate = self
        DispatchQueue.main.async {
            self.present(loginController, animated: true) {
                self.moveLogInViewRightToLeft()
            }
        }
    }
}


extension MainViewController: RegistrationViewControllerDelegate {
    func didCancelLogin(){
        UIView.animate(withDuration: Double(0.5), animations: {
            self.LoginContainXConstraint.constant = 0.0
            self.view.layoutIfNeeded()
        })
    }
}

extension MainViewController: LoginViewControllerDelegate {
    func didPressCancelBtnLogView(_ viewController: UIViewController) {
        
        viewController.dismiss(animated: true) {
            UIView.animate(withDuration: Double(0.1), animations: {
                self.LoginContainXConstraint.constant = 0.0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    
}
