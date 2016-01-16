//
//  SampleCell.swift
//  UITableView-Lifecycle-Swift
//
//  Created by Ma Dong on 1/16/16.
//  Copyright © 2016 Ma Dong. All rights reserved.
//

import UIKit

class SampleCell: UITableViewCell {
    
    @IBOutlet weak var viewInCenter: UIView!
    
    var cellRowIndex = 0;
    
    override func cellWillAppear() {
        if 0 == cellRowIndex {
            print("🍏 cellWillAppear")
            if !self.isCellWillAppearFired {
                viewInCenter.layer.cornerRadius = viewInCenter.bounds.size.width/2.0;
            }
        }
    }
    
    override func cellDidAppear() {
        if 0 == cellRowIndex {
            print("🍏🍏 cellDidAppear")

            let basicAnimation = CABasicAnimation(keyPath: "transform")
            basicAnimation.fromValue = NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
            basicAnimation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(0.8, 0.8, 1.0))
            basicAnimation.duration = 1.0
            basicAnimation.repeatCount = Float.infinity
            viewInCenter.layer.addAnimation(basicAnimation, forKey: "go")
        }
    }
    
    override func cellDidLayoutSubviews() {
        if 0 == cellRowIndex {
            print("🍏🍏🍏 cellDidLayoutSubviews")
        }
    }
    
    override func cellDidDisappear() {
        if 0 == cellRowIndex {
            print("🍎 cellDidDisappear")
        }
    }

    // MARK: - API
    func updateWithData(indexPath: NSIndexPath) {
        cellRowIndex = indexPath.row
    }
}
