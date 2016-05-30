//
//  CellProviderSample1ViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/5/31.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VAAdCellProviderDataSource
extension CellProviderSample1ViewController: VAAdCellProviderDataSource {
    
    // 插入廣告數量
    // kVAAdCellProviderNumberOfAdsUnlimited 無限多
    // kVAAdCellProviderNumberOfAdsNotInsert 零個
    // > 1 設定數量
    func tableView(tableView: UITableView, numberOfAdsInSection section: UInt) -> Int {
        return kVAAdCellProviderNumberOfAdsUnlimited
    }
    
    // 第一個 ad 會出現在哪一個 index
    func tableView(tableView: UITableView, adStartRowInSection section: UInt) -> UInt {
        return 3
    }
    
    // 之後的每個 ads 間隔
    // kVAAdCellProviderAdOffsetInsertOnlyOne 只插入一個
    func tableView(tableView: UITableView, adOffsetInSection section: UInt) -> UInt {
        return 3
    }
    
}

// MARK: VAAdCellProviderDelegate
extension CellProviderSample1ViewController: VAAdCellProviderDelegate {
    
    func adCellProvider(adCellProvider: VAAdCellProvider, didLoadAtIndexPath indexPath: NSIndexPath) {
        print("\(#function) \(indexPath)")
    }
    
    func adCellAtIndexPath(indexPath: NSIndexPath, didFailWithError error: NSError) {
        print("\(#function) \(error)")
    }
    
    func adCellProvider(adCellProvider: VAAdCellProvider, didFailAtIndexPath indexPath: NSIndexPath, withError error: NSError) {
        print("\(#function) \(indexPath) \(error)")
    }
    
    func adCellProviderDidClick(adCellProvider: VAAdCellProvider) {
        print("\(#function)")
    }
    
    func adCellProviderDidFinishHandlingClick(adCellProvider: VAAdCellProvider) {
        print("\(#function)")
    }
    
}

// MARK: UITableViewDataSource
extension CellProviderSample1ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let safeAdCellProvider = self.adCellProvider {
            let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: safeAdCellProvider.transformToWithAdAtIndexPath(indexPath))
            cell.textLabel?.text = "index : \(indexPath.row)"
            return cell
        }
        return UITableViewCell()
    }
    
}

// MARK: Private Instance Method
extension CellProviderSample1ViewController {
    
    private func retrieveSampleView1Attributes() -> VANativeAdViewAttributeObject {
        let attribute = VANativeAdViewAttributeObject()
        attribute.customAdViewClass = SampleView1.self
        attribute.customAdViewSizeHandler = { (width, ratio) in
            
            // 這邊我設定 ad 與畫面等寬
            let adWidth = CGRectGetWidth(UIScreen.mainScreen().bounds);
            
            // 高度 80 為預留給 title 和 main image, 其餘的部分, 會被等比例的壓短
            let adHeight = adWidth * ratio + 80.0;
            return CGSize(width: adWidth, height: adHeight);
        }
        return attribute
    }
    
}

// MARK: Life Cycle
class CellProviderSample1ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var adCellProvider: VAAdCellProvider?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CellProviderSample1"
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        // 建立AdCellProvider
        let adCellProvider = VAAdCellProvider(placement: "VMFiveAdNetwork_CellProviderSample1", adType: kVAAdTypeVideoCard, tableView: self.tableView, forAttributes: self.retrieveSampleView1Attributes())
        adCellProvider.testMode = true
        adCellProvider.apiKey = "YOUR API KEY"
        adCellProvider.loadAds()
        self.adCellProvider = adCellProvider
    }

}
