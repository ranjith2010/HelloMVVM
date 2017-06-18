//
//  HMUserStore.swift
//  HelloMVVM
//
//  Created by Ranjith Kumar on 10/06/2017.
//  Copyright © 2017 F22Labs. All rights reserved.
//

import Foundation

fileprivate let k_userKey = "user"
fileprivate let k_userIdKey = "u_id"
fileprivate let k_userEmailKey = "email"

class HMUserStore {
    class var shared:HMUserStore {
        struct Static {
            static let instance:HMUserStore = HMUserStore()
        }
        return Static.instance
    }
    
    var user:Dictionary<String, Any>? {
        get {
            guard let dictionary = UserDefaults.standard.object(forKey: k_userKey) as? [String:Any] else {
                return nil
            }
            return dictionary
        }
        set {
            UserDefaults.standard.set(newValue, forKey: k_userKey)
        }
    }
    
    var uid:String {
        get {
            return (self.user?[k_userIdKey] as? String)!
        }
    }
    
    var email:String {
        get {
            return (self.user?[k_userEmailKey] as? String)!
        }
    }
}
