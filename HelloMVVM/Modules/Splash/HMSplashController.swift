//
//  HMSplashController.swift
//  HelloMVVM
//
//  Created by Ranjith Kumar on 01/06/2017.
//  Copyright © 2017 F22Labs. All rights reserved.
//

import UIKit

class HMSplashController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        self.navigationController?.show(HMLoginController(), sender: nil)
    }
    
    @IBAction func didTapSignup(_ sender: Any) {
        self.navigationController?.show(HMSignupController(), sender: nil)
    }

}
