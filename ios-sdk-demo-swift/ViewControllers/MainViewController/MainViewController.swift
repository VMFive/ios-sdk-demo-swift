//
//  MainViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/5/30.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if
            let safeItems = self.items,
            let safeTitle = safeItems[section]["sectionTitle"] as? String {
            return safeTitle
        }
        return ""
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if
            let safeItems = self.items,
            let safeRows = safeItems[section]["rows"] as? NSArray {
            return safeRows.count
        }
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        cell.selectionStyle = .None
        if
            let safeItems = self.items,
            let safeRows = safeItems[indexPath.section]["rows"] as? NSArray,
            let safeRowText = safeRows[indexPath.row]["rowText"] as? String {
            cell.textLabel?.text = safeRowText == "version" ? VANativeAd.version() : safeRowText
        }
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if
            let safeItems = self.items,
            let safeRows = safeItems[indexPath.section]["rows"] as? NSArray,
            let safeAction = safeRows[indexPath.row]["action"] as? String,
            let nextController = NewController.from("ios_sdk_demo_swift.\(safeAction)") {
            self.navigationController?.pushViewController(nextController, animated: true)
        }
    }

}

// MARK: Life Cycle
class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private lazy var items: NSArray? = {
        if let safePath = NSBundle.mainBundle().pathForResource("DemoList", ofType: "plist") {
            return NSArray(contentsOfFile: safePath)
        }
        else {
            return nil
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hello Demos"
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

}
