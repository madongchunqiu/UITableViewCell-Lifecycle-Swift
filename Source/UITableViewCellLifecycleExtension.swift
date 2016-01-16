//
//  UITableViewCellLifecycleExtension.swift
//  UITableView-Lifecycle-Swift
//
//  Created by Ma Dong on 1/16/16.
//  Copyright © 2016 Ma Dong. All rights reserved.
//

import UIKit

//MARK: - define cell lifecycle events, and swizzling
extension UITableViewCell {
    func cellWillAppear() {}
    func cellDidAppear() {}
    func cellDidLayoutSubviews() {}
    func cellDidDisappear() {}
    
    dynamic func layoutSubviews_ns6Ubn0nbwOnBs() {
        self.layoutSubviews_ns6Ubn0nbwOnBs() // call the original one
        
        if (self._isCellWillOnScreen || self._isCellDidOnScreen) {
            if !self._isCellDidOnScreen {
                self._isCellWillOnScreen = false
                self.cellDidAppear()  // call action - 1
                self._isCellDidOnScreen = true
                self.isCellDidAppearFired = true // set flag afterwards - 1
            }
            
            self.cellDidLayoutSubviews()
            self.isCellDidLayoutSubviewsFired = true
        }
    }
    
    // swizzling
    override public class func initialize() {
        struct Static {
            static var tokenSwizzling: dispatch_once_t = 0
        }
        
        // make sure this isn't a subclass
        if self !== UITableViewCell.self {
            return
        }
        
        dispatch_once(&Static.tokenSwizzling) {
            let originalSelector_layoutSubviews = Selector("layoutSubviews")
            let swizzledSelector_layoutSubviews = Selector("layoutSubviews_ns6Ubn0nbwOnBs")
            
            MDRuntimeHelper.switchMethod(originalSelector_layoutSubviews,
                withMethod: swizzledSelector_layoutSubviews,
                forClass: self)
        }
    }
}


//MARK: - public property for cell status
extension UITableViewCell {
    private struct AssociatedKeys {
        static var isCellWillAppearFired = "rn5Nxh7xGhx_isCellWillAppearFired"
        static var isCellDidAppearFired = "bs6NtqnxP8e_isCellDidAppearFired"
        static var isCellDidLayoutSubviewsFired = "mvD3nzs7kHk_isCellDidLayoutSubviewsFired"
    }
    
    var isCellWillAppearFired: Bool {
        get {
            if let ret = objc_getAssociatedObject(self, &AssociatedKeys.isCellWillAppearFired) as? Bool {
                return ret
            }
            return false
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.isCellWillAppearFired,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    var isCellDidAppearFired: Bool {
        get {
            if let ret = objc_getAssociatedObject(self, &AssociatedKeys.isCellDidAppearFired) as? Bool {
                return ret
            }
            return false
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.isCellDidAppearFired,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

    var isCellDidLayoutSubviewsFired: Bool {
        get {
            if let ret = objc_getAssociatedObject(self, &AssociatedKeys.isCellDidLayoutSubviewsFired) as? Bool {
                return ret
            }
            return false
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.isCellDidLayoutSubviewsFired,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

//MARK: -  internal property for cell status
extension UITableViewCell {
    private struct AssociatedKeysInternal {
        static var isCellWillOnScreen = "jwL6nsOq2lU_isCellWillOnScreen"
        static var isCellDidOnScreen = "px8Nslw1nNs_isCellDidOnScreen"
    }
    
    var _isCellWillOnScreen: Bool { // supposed to be private...
        get {
            if let ret = objc_getAssociatedObject(self, &AssociatedKeysInternal.isCellWillOnScreen) as? Bool {
                return ret
            }
            return false
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeysInternal.isCellWillOnScreen,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }

    var _isCellDidOnScreen: Bool { // supposed to be private...
        get {
            if let ret = objc_getAssociatedObject(self, &AssociatedKeysInternal.isCellDidOnScreen) as? Bool {
                return ret
            }
            return false
        }
        
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeysInternal.isCellDidOnScreen,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}
