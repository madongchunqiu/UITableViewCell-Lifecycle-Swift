# Description
The `UITableViewCellLifecycleExtension` extension (with `MDTableViewDelegate`) provide lifecycle events for *UITableViewCell*, just like UIViewController:
* cellWillAppear
* cellDidAppear
* cellDidLayoutSubviews
* cellDidDisappear


![Debug log](https://github.com/madongchunqiu/UITableView-Lifecycle-Swift/blob/master/UITableView-Lifecycle-Swift.gif)  


# Why
I'm a big fan of **UITableView**, since it provides the flexibility of organizing contents dynamically. And with more and more animations in the UI, I found it hard to locate my code elegantly.  
On the other hand, UIViewController is nice with viewWillAppear, viewDidAppear, viewDidLayoutSubviews, viewWillDisappear and viewDidDisappear etc.   
I though I shall make this happen to *UITableViewCell*.  

# How to Use
*see the sample code*

* include `UITableViewCellLifecycleExtension.swift` and `MDTableViewDelegate.swift` into the projects. Subclass MDTableViewDelegate, and put your tableView's dataSource and delegate code in this class. And these events will be triggerred in the cells. 
* be sure to call `super.tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)` when implementing an override version of `tableView:willDisplayCell:forRowAtIndexPath` in your subclass of MDTableViewDelegate
* if UITableViewController's cells want to have these events, when impelementing the delegate within the table view controller, please refer to the implementation of `UITableViewController+Lifecycle.h/m` in the Objective-C version (see below) and `MDTableViewDelegate.swift`  

# Objective-C version
[UITableViewCell-Lifecycle](https://github.com/madongchunqiu/UITableViewCell-Lifecycle)

# Known Issues
These events won't be triggerred if the whole tableView is going on-screen or off-screen, e.g. when pushing another view controller or poped back. (Currently I don't see the need to fix this.)  
It only happens when the *UITableViewCell* is scrolling into the screen or scrolling out-side of the screen.
