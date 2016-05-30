//
//  NativeAdSample2ViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/5/31.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VANativeAdDelegate
extension NativeAdSample2ViewController: VANativeAdDelegate {
    
    func nativeAdDidLoad(nativeAd: VANativeAd) {
        var render: VANativeAdViewRender
        if let safeAdView = self.adView {
            render = VANativeAdViewRender(nativeAd: nativeAd, customAdView: safeAdView)
        }
        else {
            render = VANativeAdViewRender(nativeAd: nativeAd, customizedAdViewClass: SampleView2.self)
        }
        
        render.renderWithCompleteHandler { [weak self] (view, error) in
            guard let safeSelf = self else {
                return
            }
            
            if let safeError = error {
                print("Error : \(safeError)")
            }
            else {
                if let safeView = view as? SampleView2 {
                    safeView.onClose = {
                        safeSelf.hideAd()
                    }
                    safeSelf.adView = safeView
                }
            }
            
            safeSelf.isAdReady = (error == nil)
            safeSelf.tableView.reloadData()
        }
    }
    
    func nativeAd(nativeAd: VANativeAd, didFailedWithError error: NSError) {
        print("\(#function) \(error)")
    }
    
    func nativeAdDidClick(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdDidFinishHandlingClick(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdBeImpressed(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdDidFinishImpression(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
}

// MARK: UITableViewDataSource
extension NativeAdSample2ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count + self.isAdReadyIntValue
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        if let safeAdView = self.adView where self.isAdReady && indexPath.row == 0 {
            cell.textLabel?.text = safeAdView.titleLabel.text
        }
        else {
            cell.textLabel?.text = self.titles[indexPath.row - self.isAdReadyIntValue]
        }
        return cell
    }
    
}

// MARK: UITableViewDelegate
extension NativeAdSample2ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.isAdReady && indexPath.row == 0 {
            self.showAd()
        }
        else {
            let alert = UIAlertController(title: "點到了", message: self.titles[indexPath.row - self.isAdReadyIntValue], preferredStyle: .Alert)
            let action = UIAlertAction(title: "確定", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
}

// MARK: Private Instance Method
extension NativeAdSample2ViewController {
    
    private func showAd() {
        if let safeAdView = self.adView {
            self.view.addSubview(safeAdView)
            
            // autolayout 設定, 固定大小, 水平垂直置中
            safeAdView.translatesAutoresizingMaskIntoConstraints = false
            safeAdView.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGRectGetWidth(safeAdView.bounds)))
            safeAdView.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGRectGetHeight(safeAdView.bounds)))
            
            self.view.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1.0, constant: 0))
            self.view.layoutIfNeeded()
            
            safeAdView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0, 0);
            UIView.animateWithDuration(0.15, animations: { [weak self] in
                guard let safeSelf = self else {
                    return
                }
                safeSelf.adView?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
            }) { [weak self] (finished) in
                UIView.animateWithDuration(0.15, animations: { [weak self] in
                    guard let safeSelf = self else {
                        return
                    }
                    safeSelf.adView?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
                }, completion:nil)
            }
        }
    }
    
    private func hideAd() {
        UIView.animateWithDuration(0.15, animations: { [weak self] in
            guard let safeSelf = self else {
                return
            }
            safeSelf.adView?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        }) { [weak self] (finished) in
            UIView.animateWithDuration(0.15, animations: { [weak self] in
                guard let safeSelf = self else {
                    return
                }
                safeSelf.adView?.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
            }, completion: { [weak self] (finished) in
                guard let safeSelf = self else {
                    return
                }
                safeSelf.adView?.removeFromSuperview()
                safeSelf.nativeAd.loadAd()
            })
        }
    }
    
}

// MARK: Life Cycle
class NativeAdSample2ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let nativeAd = VANativeAd(placement: "VMFiveAdNetwork_NativeAdSample2", adType: kVAAdTypeVideoCard)
    private var adView: SampleView2?
    private var isAdReady = false
    private var isAdReadyIntValue: Int {
        return (self.isAdReady == false ? 0 : 1)
    }
    private let titles = [ "第四集", "第三集", "第二集", "第一集" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NativeAdSample2"
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.nativeAd.testMode = true;
        self.nativeAd.apiKey = "YOUR API KEY HERE";
        self.nativeAd.delegate = self;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.nativeAd.loadAd()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.nativeAd.unloadAd()
    }

}
