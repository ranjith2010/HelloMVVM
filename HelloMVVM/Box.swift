//
//  Box.swift
//  HelloMVVM
//
//  Created by Ranjith Kumar on 9/4/17.
//  Copyright © 2017 F22Labs. All rights reserved.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
