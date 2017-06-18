//
//  HMHomeViewModel.swift
//  HelloMVVM
//
//  Created by Ranjith Kumar on 05/06/2017.
//  Copyright © 2017 F22Labs. All rights reserved.
//

import Foundation

protocol BasicTableViewDelegates {
    func numberOfSection()->Int
    func numberOfRows(in section:Int)->Int
    func objectForRow(at indexpath:IndexPath)->NSObject
}

class HMHomeViewModel:NSObject,BasicTableViewDelegates {
    
    func numberOfSection()->Int {
        return 1
    }
    
    func numberOfRows(in section:Int)->Int {
        return 10
    }
    
    func objectForRow(at indexpath:IndexPath)->NSObject {
        return NSObject()
    }
    
}
