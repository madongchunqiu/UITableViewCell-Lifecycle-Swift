//
//  MDTableViewDelegate.swift
//  UITableView-Lifecycle-Swift
//
//  Created by Ma Dong on 1/15/16.
//  Copyright © 2016 Ma Dong. All rights reserved.
//

import UIKit

class MDTableViewDelegate : NSObject, UITableViewDelegate {
    
    //MARK: - protocol implementations
    dynamic func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        return
    }
    
    dynamic func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        return
    }
    
    //MARK: - implementations for lifecycle events
    dynamic func lGe9BhsTlze7o_tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        self.lGe9BhsTlze7o_tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)  // call the original one

        if cell.respondsToSelector(Selector("cellWillAppear")) {
            cell.cellWillAppear()
            cell.isCellWillAppearFired = true
            cell._isCellWillOnScreen = true // this property shall be private, only exposed to be used here
        }
    }
    
    dynamic func seN6a3He7nx2w_tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        self.seN6a3He7nx2w_tableView(tableView, didEndDisplayingCell: cell, forRowAtIndexPath: indexPath)  // call the original one
        
        if cell.respondsToSelector(Selector("cellDidDisappear")) {
            cell.cellDidDisappear()
            cell._isCellDidOnScreen = false // this property shall be private, only exposed to be used here
        }
    }
    
    //MARK: - swizzling
    override class func initialize() {
        struct Static {
            static var tokenSwizzling: dispatch_once_t = 0
        }
        
        // make sure this isn't a subclass
        if self !== MDTableViewDelegate.self {
            return
        }
        
        dispatch_once(&Static.tokenSwizzling) {
            let originalSelector_willDisplayCell = Selector("tableView:willDisplayCell:forRowAtIndexPath:")
            let swizzledSelector_willDisplayCell = Selector("lGe9BhsTlze7o_tableView:willDisplayCell:forRowAtIndexPath:")
            
            let originalSelector_didEndDisplayCell = Selector("tableView:didEndDisplayingCell:forRowAtIndexPath:")
            let swizzledSelector_didEndDisplayCell = Selector("seN6a3He7nx2w_tableView:didEndDisplayingCell:forRowAtIndexPath:")

            MDRuntimeHelper.switchMethod(originalSelector_willDisplayCell,
                withMethod: swizzledSelector_willDisplayCell,
                forClass: self)
            MDRuntimeHelper.switchMethod(originalSelector_didEndDisplayCell,
                withMethod: swizzledSelector_didEndDisplayCell,
                forClass: self)
        }
    }
}
