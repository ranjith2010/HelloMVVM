//
//  HMLoginController.swift
//  HelloMVVM
//
//  Created by Ranjith Kumar on 01/06/2017.
//  Copyright © 2017 F22Labs. All rights reserved.
//

import UIKit
import FirebaseAuth

class HMLoginController: UIViewController {

    @IBOutlet private weak var txtField_email:UITextField?
    @IBOutlet private weak var txtField_password:UITextField?
    
    public var viewModel:HMLoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HMLoginViewModel()
        viewModel?.viewDelegate = self
    }

    @IBAction func didTapLogin(_ sender: Any) {
        guard let email = txtField_email?.text,
        let pwd = txtField_password?.text else {
            return
        }
        self.viewModel?.login(with: email, and: pwd)
    }
}

extension HMLoginController:HMLoginViewProtocol {
    func loginCompletion(user: FIRUser?, error: Error?) {
        guard let u = user else {
            print("error:\(String(describing: error?.localizedDescription))")
            return
        }
        guard let email = u.email,let uid = user?.uid else{
            return
        }
        HMUserStore.shared.user = ["email":email,"u_id":uid]
        print("Logged in with:\(user?.email ?? "")")
        let appdelegate = UIApplication.shared.delegate as? AppDelegate
        appdelegate?.app?.window.rootViewController = HMChatRoomsController()
    }
}
