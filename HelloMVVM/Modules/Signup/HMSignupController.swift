//
//  HMSignupController.swift
//  HelloMVVM
//
//  Created by Ranjith Kumar on 01/06/2017.
//  Copyright © 2017 F22Labs. All rights reserved.
//

import UIKit
import FirebaseAuth

class HMSignupController: UIViewController {
    
    @IBOutlet private weak var txtField_Email:UITextField?
    @IBOutlet private weak var txtField_password:UITextField?
    
    var str1:Box<String?> = Box(nil)
    
    public var viewModel:HMSignupViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HMSignupViewModel()
        viewModel?.viewDelegate = self
        viewModel?.str1Ref = str1
        
        str1.bind { (newValue) in
            print("Hello \(newValue ?? "")")
        }
    }
    
    @IBAction func didTapSignup(){
        guard let email = txtField_Email?.text,
            let pwd = txtField_password?.text else {
                return
        }
        if email.isEmpty || pwd.isEmpty {
            print("Enter correct input Fields")
        }else {
            viewModel?.signup(with: email, and: pwd)
        }
    }
    
}

extension HMSignupController:HMSignupViewProtocol {
    func signupCompletion(user: User?, error: Error?) {
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

