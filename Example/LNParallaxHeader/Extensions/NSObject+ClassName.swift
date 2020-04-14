//
//  NSObject+ClassName.swift
//  
//
//  Copyright © 2020 Lanars. All rights reserved.
//  https://lanars.com/
//

import Foundation

extension NSObject {
    
    /// String describing the class name.
    static var className: String {
        return String(describing: self)
    }
    
}
