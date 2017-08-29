//
//  HMSignupViewModel.swift
//  HelloMVVM
//
//  Created by Ranjith Kumar on 01/06/2017.
//  Copyright © 2017 F22Labs. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol HMSignupViewProtocol:class {
    func signupCompletion(user:User?,error:Error?)
}

class HMSignupViewModel: NSObject {
    
    public weak var viewDelegate:HMSignupViewProtocol?
    
    public func signup(with email:String, and password:String) {
        Auth.auth().createUser(withEmail: email, password: password, completion: {(user, error) in
            self.viewDelegate?.signupCompletion(user: user, error: error)
        })
    }
}
