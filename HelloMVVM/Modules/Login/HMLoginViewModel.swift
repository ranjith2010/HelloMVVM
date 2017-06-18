//
//  HMLoginViewModel.swift
//  HelloMVVM
//
//  Created by Ranjith Kumar on 01/06/2017.
//  Copyright © 2017 F22Labs. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol HMLoginViewProtocol:class {
    func loginCompletion(user: FIRUser?,error:Error?)
}

class HMLoginViewModel: NSObject {
    
    public weak var viewDelegate:HMLoginViewProtocol?
    
    public func login(with email:String, and password:String) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            guard let email = user?.email, let uid = user?.uid else{
                return
            }
            HMUserStore.shared.user = ["email":email,"u_id":uid]
            self.viewDelegate?.loginCompletion(user: user, error: error)
        })
    }
}
