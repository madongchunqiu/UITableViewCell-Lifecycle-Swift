# Description
The UITableViewCell's swift extension of `UITableViewCellLifecycleExtension` (with `MDTableViewDelegate`) provide lifecycle events for *UITableViewCell*, just like UIViewController:
* cellWillAppear
* cellDidAppear
* cellDidLayoutSubviews
* cellDidDisappear


![Debug log](https://github.com/madongchunqiu/UITableViewCell-Lifecycle-Swift/blob/master/UITableView-Lifecycle-Swift.gif)  


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
```
The difference between Objective-C version and Swift version is:   
the Objective-C version swizzle method `tableView:willDisplayCell:forRowAtIndexPath:` in all the subclass of `MDTableViewDelegate`, not `MDTableViewDelegate` itself.
By doing this, there is not need to call `super.tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)`, and all the hacking details are hidden.
```

# Known Issues
These events won't be triggerred if the whole tableView is going on-screen or off-screen, e.g. when pushing another view controller or poped back. (Currently I don't see the need to fix this.)  
It only happens when the *UITableViewCell* is scrolling into the screen or scrolling out-side of the screen.

# 中文说明
[给TableViewCell加上生命周期事件（如cellWillAppear）(下)](http://www.jianshu.com/p/64c76a587450)
