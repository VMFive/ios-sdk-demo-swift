//
//  CellProviderSample1ViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/5/31.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: UITableViewCell Extension
extension UITableViewCell {
    
    var indexPath: NSIndexPath? {
        get {
            return self.dependTableView()?.indexPathForCell(self)
        }
    }

    private func dependTableView() -> UITableView? {

        var findView: UIView? = self.superview
        repeat
        {
            if findView == nil {
                return nil
            }
            else if let checkView = findView as? UITableView {
                return checkView
            }
            else {
                findView = findView?.superview
            }
        } while(true)
    }
}

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
        return 4
    }
    
    // 之後的每個 ads 間隔
    // kVAAdCellProviderAdOffsetInsertOnlyOne 只插入一個
    func tableView(tableView: UITableView, adOffsetInSection section: UInt) -> UInt {
        return 8
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
        return self.pets.count * 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let transformIndexPath = self.adCellProvider?.transformToWithAdAtIndexPath(indexPath) ?? NSIndexPath(forRow: 0, inSection: 0)
        let petIndex = indexPath.row / 4
        let currentInfo = self.pets[petIndex]
        
        switch indexPath.row % 4 {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: transformIndexPath)
            cell.selectionStyle = .None
            cell.textLabel?.textAlignment = .Left
            cell.textLabel?.text = "領養動物編號 : \(petIndex + 1)"
            return cell
            
        case 1:
            if let cell = tableView.dequeueReusableCellWithIdentifier("PetImageTableViewCell", forIndexPath: transformIndexPath) as? PetImageTableViewCell {
                cell.selectionStyle = .None
                cell.petImageView.image = nil
                
                if let safeImageName = currentInfo["ImageName"] {
                    if
                        self.imageCache.objectForKey(safeImageName) != nil,
                        let safeData = self.imageCache.objectForKey(safeImageName) as? NSData {
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                            let image = UIImage(data: safeData)
                            dispatch_async(dispatch_get_main_queue(), {
                                cell.petImageView.image = image
                            })
                        })
                    }
                    else {
                        if let safeURL = NSURL(string: safeImageName) {
                            let keepRow = transformIndexPath.row
                            NSURLSession.sharedSession().dataTaskWithURL(safeURL, completionHandler: { [weak self] (data, response, error) in
                                guard let safeSelf = self else {
                                    return
                                }
                                
                                if error != nil {
                                    print("Error : \(error)")
                                }
                                else if let safeData = data {
                                    safeSelf.imageCache.setObject(safeData, forKey: safeImageName)
                                    let image = UIImage(data: safeData)
                                    dispatch_async(dispatch_get_main_queue(), {
                                        if let safeIndexPath = cell.indexPath where safeIndexPath.row == keepRow {
                                            cell.petImageView.image = image
                                        }
                                    })
                                }
                            }).resume()
                        }
                    }
                }
                return cell
            }
            
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: transformIndexPath)
            cell.selectionStyle = .None
            if let safeTextLabel = cell.textLabel {
                safeTextLabel.textAlignment = .Center
                let sex = currentInfo["Sex"] == "雄" ? "♂" : "♀"
                if let safeName = currentInfo["Name"] {
                    safeTextLabel.text = "\(sex) \(safeName)"
                }
            }
            return cell
            
        case 3:
            if let cell = tableView.dequeueReusableCellWithIdentifier("NoteTableViewCell", forIndexPath: transformIndexPath) as? NoteTableViewCell {
                cell.selectionStyle = .None
                if let safeTextView = cell.textView {
                    safeTextView.text = currentInfo["Note"]
                }
                return cell
            }
            
        default:
            break
        }
        
        return UITableViewCell()
    }
    
}

extension CellProviderSample1ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row % 4 {
        case 0:
            return 40.0
            
        case 1:
            return 200.0
            
        case 2:
            return 40.0
            
        case 3:
            if let safeHeight = self.rowHeight.objectForKey(indexPath) as? NSNumber {
                return CGFloat(safeHeight.floatValue)
            }
            else {
                let petIndex = indexPath.row / 4
                let currentInfo = self.pets[petIndex]
                self.dummyCell.textView.text = currentInfo["Note"]
                let sizeThatFitsTextView = self.dummyCell.textView.sizeThatFits(CGSize(width: CGRectGetWidth(dummyCell.textView.frame), height: CGFloat.max))
                self.rowHeight.setObject(NSNumber(float: Float(sizeThatFitsTextView.height) + 30), forKey: indexPath)
                return sizeThatFitsTextView.height + 30
            }
            
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(#function) \(indexPath)")
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
            
            // 高度 30 為預留給 main image, 其餘的部分, 會被等比例的壓短
            let adHeight = adWidth * ratio + 30.0;
            return CGSize(width: adWidth, height: adHeight);
        }
        return attribute
    }
    
    private func fetchPets() {
        if let safeURL = NSURL(string: "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=f4a75ba9-7721-4363-884d-c3820b0b917c") {
            
            NSURLSession.sharedSession().dataTaskWithURL(safeURL, completionHandler: { [weak self] (data, response, error) -> Void in
                guard let safeSelf = self else {
                    return
                }
                
                if error != nil {
                    print("Error : \(error)")
                }
                else {
                    if
                        let safeData = data,
                        let responseJSON = try? NSJSONSerialization.JSONObjectWithData(safeData, options: .MutableContainers),
                        let safeResponseJSON = responseJSON as? [String: AnyObject],
                        let safeResult = safeResponseJSON["result"] as? [String: AnyObject],
                        let safeResults = safeResult["results"] as? [[String: String]] {
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            safeSelf.pets = safeResults
                            safeSelf.tableView.reloadData()
                        })
                    }
                    else {
                        print("Data Parse Error")
                    }
                }
            }).resume()
        }
        else {
            print("Invalid URL")
        }
    }
    
}

// MARK: Life Cycle
class CellProviderSample1ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var adCellProvider: VAAdCellProvider?
    var pets: [[String: String]] = []
    let imageCache = NSCache()
    let rowHeight = NSCache()
    let dummyCell: NoteTableViewCell = NSBundle.mainBundle().loadNibNamed("NoteTableViewCell", owner: nil, options: nil)[0] as! NoteTableViewCell

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CellProviderSample1"
        self.imageCache.countLimit = 15
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableView.registerNib(UINib(nibName: "PetImageTableViewCell", bundle: nil), forCellReuseIdentifier: "PetImageTableViewCell")
        self.tableView.registerNib(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTableViewCell")
        
        // 建立AdCellProvider
        let adCellProvider = VAAdCellProvider(placement: "VMFiveAdNetwork_CellProviderSample1", adType: kVAAdTypeVideoCard, tableView: self.tableView, forAttributes: self.retrieveSampleView1Attributes())
        adCellProvider.testMode = true
        adCellProvider.apiKey = "YOUR API KEY"
        adCellProvider.loadAds()
        self.adCellProvider = adCellProvider
        
        // 下載流浪動物列表
        self.fetchPets()
    }

}
