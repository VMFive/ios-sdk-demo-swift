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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if
            let safeItems = self.items,
            let safeSection = safeItems[section] as? [String : AnyObject],
            let safeTitle = safeSection["sectionTitle"] as? String {
            return safeTitle
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if
            let safeItems = self.items,
            let safeSection = safeItems[section] as? [String : AnyObject],
            let safeRows = safeSection["rows"] as? NSArray {
            return safeRows.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        if
            let safeItems = self.items,
            let safeSection = safeItems[indexPath.section] as? [String : AnyObject],
            let safeRows = safeSection["rows"] as? NSArray,
            let safeRow = safeRows[indexPath.row] as? [String : AnyObject],
            let safeRowText = safeRow["rowText"] as? String {
            cell.textLabel?.text = safeRowText == "version" ? VANativeAd.version() : safeRowText
        }
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if
            let safeItems = self.items,
            let safeSection = safeItems[indexPath.section] as? [String : AnyObject],
            let safeRows = safeSection["rows"] as? NSArray,
            let safeRow = safeRows[indexPath.row] as? [String : AnyObject],
            let safeAction = safeRow["action"] as? String,
            let nextController = NewController.from("ios_sdk_demo_swift.\(safeAction)") {
            self.navigationController?.pushViewController(nextController, animated: true)
        }
    }

}

// MARK: Life Cycle
class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    fileprivate lazy var items: NSArray? = {
        if let safePath = Bundle.main.path(forResource: "DemoList", ofType: "plist") {
            return NSArray(contentsOfFile: safePath)
        }
        else {
            return nil
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Hello Demos"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

}
