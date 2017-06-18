//
//  HMApp.swift
//  HelloMVVM
//
//  Created by Ranjith Kumar on 01/06/2017.
//  Copyright © 2017 F22Labs. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class HMApp:NSObject {
    var launchOptions:[UIApplicationLaunchOptionsKey: Any]?
    
    lazy var window: UIWindow = {
        return  UIWindow.init(frame: UIScreen.main.bounds)
    }()
    
    convenience init(launchOptions:[UIApplicationLaunchOptionsKey: Any]?) {
        self.init()
        self.addConfiguration()
        self.launchOptions = launchOptions
        if let _ = HMUserStore.shared.user {
            window.rootViewController = UINavigationController.init(rootViewController: HMChatRoomsController())
        }else {
            window.rootViewController = UINavigationController.init(rootViewController:HMSplashController())
        }
        window.makeKeyAndVisible()
    }
    
    func addConfiguration() {
        FIRApp.configure()
    }
    
}
