//
//  Box.swift
//  Pizza Nik
//
//  Created by Yaroslav Abaturov on 14/06/2018.
//  Copyright © 2018 Yaroslav Abaturov. All rights reserved.
//

import Foundation

class Box <T> {
    typealias Listener = (T) -> ()
    
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
    
    init(_ value: T) {
        self.value = value
    }
}
