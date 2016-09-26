//
//  CellProviderSample2ViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/5/31.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VAAdCellProviderDataSource
extension CellProviderSample2ViewController: VAAdCellProviderDataSource {
    
    // 插入廣告數量
    // kVAAdCellProviderNumberOfAdsUnlimited 無限多
    // kVAAdCellProviderNumberOfAdsNotInsert 零個
    // > 1 設定數量
    func tableView(_ tableView: UITableView, numberOfAdsInSection section: UInt) -> Int {
        return kVAAdCellProviderNumberOfAdsUnlimited
    }
    
    // 第一個 ad 會出現在哪一個 index
    func tableView(_ tableView: UITableView, adStartRowInSection section: UInt) -> UInt {
        return 0
    }
    
    // 之後的每個 ads 間隔
    // kVAAdCellProviderAdOffsetInsertOnlyOne 只插入一個
    func tableView(_ tableView: UITableView, adOffsetInSection section: UInt) -> UInt {
        return 4
    }
    
}

// MARK: VAAdCellProviderDelegate
extension CellProviderSample2ViewController: VAAdCellProviderDelegate {
    
    func adCellProvider(_ adCellProvider: VAAdCellProvider, didLoadAt indexPath: IndexPath) {
        print("\(#function) \(indexPath)")
    }
    
    func adCell(at indexPath: IndexPath, didFailWithError error: Error) {
        print("\(#function) \(error)")
    }
    
    func adCellProvider(_ adCellProvider: VAAdCellProvider, didFailAt indexPath: IndexPath, withError error: Error) {
        print("\(#function) \(indexPath) \(error)")
    }
    
    func adCellProviderDidClick(_ adCellProvider: VAAdCellProvider) {
        print("\(#function)")
    }
    
    func adCellProviderDidFinishHandlingClick(_ adCellProvider: VAAdCellProvider) {
        print("\(#function)")
    }
    
}

// MARK: UITableViewDataSource
extension CellProviderSample2ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let safeAdCellProvider = self.adCellProvider {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: safeAdCellProvider.transformToWithAd(at: indexPath))
            cell.textLabel?.text = "index : \(indexPath.row)"
            return cell
        }
        return UITableViewCell()
    }
    
}

// MARK: Private Instance Method
extension CellProviderSample2ViewController {
    
    fileprivate func retrieveSampleView3Attributes() -> VANativeAdViewAttributeObject {
        let attribute = VANativeAdViewAttributeObject();
        attribute.customAdViewClass = SampleView3.self;
        attribute.customAdViewSizeHandler = { (width, ratio) in
            if (width * (210.0 / 320.0) > 250.0) {
                return CGSize(width: 250.0 * (320.0 / 210.0), height: 250.0);
            }
            else {
                return CGSize(width: width, height: width * (210.0 / 320.0));
            }
        };
        return attribute;
    }
    
}

// MARK: Life Cycle
class CellProviderSample2ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    fileprivate var adCellProvider: VAAdCellProvider?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CellProviderSample3"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
        let adCellProvider = VAAdCellProvider(placement: "VMFiveAdNetwork_CellProviderSample3", adType: kVAAdTypeVideoCard, tableView: self.tableView, forAttributes: self.retrieveSampleView3Attributes())
        adCellProvider.testMode = true
        adCellProvider.apiKey = "YOUR API KEY"
        adCellProvider.loadAds()
        self.adCellProvider = adCellProvider
    }

}
