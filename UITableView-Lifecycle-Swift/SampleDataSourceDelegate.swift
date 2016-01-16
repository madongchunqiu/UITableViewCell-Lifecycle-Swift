//
//  SampleDataSourceDelegate.swift
//  UITableView-Lifecycle-Swift
//
//  Created by Ma Dong on 1/16/16.
//  Copyright © 2016 Ma Dong. All rights reserved.
//

import UIKit

private let cellIdentifier = "SampleCell"

class SampleDataSourceDelegate : MDTableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UIScreen.mainScreen().bounds.size.height / 2.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        if let cell = cell as? SampleCell {
            cell.updateWithData(indexPath)
        }
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
        cell.alpha = 0.5
    }
}
