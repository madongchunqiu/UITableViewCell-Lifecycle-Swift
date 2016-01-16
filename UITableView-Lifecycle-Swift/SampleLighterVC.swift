//
//  SampleLighterVC.swift
//  UITableView-Lifecycle-Swift
//
//  Created by Ma Dong on 1/15/16.
//  Copyright © 2016 Ma Dong. All rights reserved.
//

import UIKit

class SampleLighterVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var delegateDelegate = SampleDataSourceDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = delegateDelegate
        self.tableView.delegate = delegateDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

