//
//  MDRuntimeHelper.swift
//  UITableView-Lifecycle-Swift
//
//  Created by Ma Dong on 1/16/16.
//  Copyright © 2016 Ma Dong. All rights reserved.
//

import Foundation

struct MDRuntimeHelper {
    static func switchMethod(originalSelector : Selector, withMethod swizzledSelector : Selector, forClass cls : AnyClass) {
        let originalMethod = class_getInstanceMethod(cls, originalSelector)
        let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)
        
        let didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
}
 