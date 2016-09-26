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
            return self.dependTableView()?.indexPath(for: self) as NSIndexPath?
        }
    }

    fileprivate func dependTableView() -> UITableView? {

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
    func tableView(_ tableView: UITableView, numberOfAdsInSection section: UInt) -> Int {
        return kVAAdCellProviderNumberOfAdsUnlimited
    }
    
    // 第一個 ad 會出現在哪一個 index
    func tableView(_ tableView: UITableView, adStartRowInSection section: UInt) -> UInt {
        return 4
    }
    
    // 之後的每個 ads 間隔
    // kVAAdCellProviderAdOffsetInsertOnlyOne 只插入一個
    func tableView(_ tableView: UITableView, adOffsetInSection section: UInt) -> UInt {
        return 8
    }
    
}

// MARK: VAAdCellProviderDelegate
extension CellProviderSample1ViewController: VAAdCellProviderDelegate {
    
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
extension CellProviderSample1ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pets.count * 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let transformIndexPath = self.adCellProvider?.transformToWithAd(at: indexPath) ?? IndexPath(row: 0, section: 0)
        let petIndex = indexPath.row / 4
        let currentInfo = self.pets[petIndex]
        
        switch indexPath.row % 4 {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: transformIndexPath)
            cell.selectionStyle = .none
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.text = "領養動物編號 : \(petIndex + 1)"
            return cell
            
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PetImageTableViewCell", for: transformIndexPath) as? PetImageTableViewCell {
                cell.selectionStyle = .none
                cell.petImageView.image = nil
                
                if let safeImageName = currentInfo["ImageName"] {
                    if
                        self.imageCache.object(forKey: safeImageName as NSString) != nil,
                        let safeData = self.imageCache.object(forKey: safeImageName as NSString) {
                        DispatchQueue.global(qos: .default).async {
                            let image = UIImage(data: safeData as Data)
                            DispatchQueue.main.async {
                                cell.petImageView.image = image
                            }
                        }
                    }
                    else {
                        if let safeURL = NSURL(string: safeImageName) {
                            let keepRow = transformIndexPath.row
                            URLSession.shared.dataTask(with: safeURL as URL, completionHandler: { [weak self] (data, response, error) in
                                guard let safeSelf = self else {
                                    return
                                }
                                
                                if error != nil {
                                    print("Error : \(error)")
                                }
                                else if let safeData = data {
                                    safeSelf.imageCache.setObject(safeData as NSData, forKey: safeImageName as NSString)
                                    let image = UIImage(data: safeData)
                                    DispatchQueue.main.async {
                                        if let safeIndexPath = cell.indexPath, safeIndexPath.row == keepRow {
                                            cell.petImageView.image = image
                                        }
                                    }
                                }
                            }).resume()
                        }
                    }
                }
                return cell
            }
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: transformIndexPath)
            cell.selectionStyle = .none
            if let safeTextLabel = cell.textLabel {
                safeTextLabel.textAlignment = .center
                let sex = currentInfo["Sex"] == "雄" ? "♂" : "♀"
                if let safeName = currentInfo["Name"] {
                    safeTextLabel.text = "\(sex) \(safeName)"
                }
            }
            return cell
            
        case 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: transformIndexPath) as? NoteTableViewCell {
                cell.selectionStyle = .none
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row % 4 {
        case 0:
            return 40.0
            
        case 1:
            return 200.0
            
        case 2:
            return 40.0
            
        case 3:
            if let safeHeight = self.rowHeight.object(forKey: indexPath as NSIndexPath) {
                return CGFloat(safeHeight.floatValue)
            }
            else {
                let petIndex = indexPath.row / 4
                let currentInfo = self.pets[petIndex]
                self.dummyCell.textView.text = currentInfo["Note"]
                let sizeThatFitsTextView = self.dummyCell.textView.sizeThatFits(CGSize(width: dummyCell.textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
                self.rowHeight.setObject(NSNumber(value: Float(sizeThatFitsTextView.height) + 30), forKey: indexPath as NSIndexPath)
                return sizeThatFitsTextView.height + 30
            }
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(#function) \(indexPath)")
    }
    
}

// MARK: Private Instance Method
extension CellProviderSample1ViewController {
    
    fileprivate func retrieveSampleView1Attributes() -> VANativeAdViewAttributeObject {
        let attribute = VANativeAdViewAttributeObject()
        attribute.customAdViewClass = SampleView1.self
        attribute.customAdViewSizeHandler = { (width, ratio) in
            
            // 這邊我設定 ad 與畫面等寬
            let adWidth = UIScreen.main.bounds.width;
            
            // 高度 30 為預留給 main image, 其餘的部分, 會被等比例的壓短
            let adHeight = adWidth * ratio + 30.0;
            return CGSize(width: adWidth, height: adHeight);
        }
        return attribute
    }
    
    fileprivate func fetchPets() {
        if let safeURL = NSURL(string: "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=f4a75ba9-7721-4363-884d-c3820b0b917c") {
            
            URLSession.shared.dataTask(with: safeURL as URL, completionHandler: { [weak self] (data, response, error) -> Void in
                guard let safeSelf = self else {
                    return
                }
                
                if error != nil {
                    print("Error : \(error)")
                }
                else {
                    if
                        let safeData = data,
                        let responseJSON = try? JSONSerialization.jsonObject(with: safeData, options: .mutableContainers),
                        let safeResponseJSON = responseJSON as? [String: AnyObject],
                        let safeResult = safeResponseJSON["result"] as? [String: AnyObject],
                        let safeResults = safeResult["results"] as? [[String: String]] {
                        
                        DispatchQueue.main.async {
                            safeSelf.pets = safeResults
                            safeSelf.tableView.reloadData()
                        }
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
    fileprivate var adCellProvider: VAAdCellProvider?
    var pets: [[String: String]] = []
    let imageCache = NSCache<NSString, NSData>()
    let rowHeight = NSCache<NSIndexPath, NSNumber>()
    let dummyCell: NoteTableViewCell = Bundle.main.loadNibNamed("NoteTableViewCell", owner: nil, options: nil)![0] as! NoteTableViewCell

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CellProviderSample1"
        self.imageCache.countLimit = 15
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableView.register(UINib(nibName: "PetImageTableViewCell", bundle: nil), forCellReuseIdentifier: "PetImageTableViewCell")
        self.tableView.register(UINib(nibName: "NoteTableViewCell", bundle: nil), forCellReuseIdentifier: "NoteTableViewCell")
        
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
