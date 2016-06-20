//
//  NativeAdSample6ViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/6/20.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VANativeAdDelegate
extension NativeAdSample6ViewController: VANativeAdDelegate {
    
    func nativeAdDidLoad(nativeAd: VANativeAd) {
        var render: VANativeAdViewRender
        if let safeAdView = self.adView {
            render = VANativeAdViewRender(nativeAd: nativeAd, customAdView: safeAdView)
        }
        else {
            render = VANativeAdViewRender(nativeAd: nativeAd, customizedAdViewClass: SampleView4.self)
        }
        
        render.renderWithCompleteHandler { [weak self] (view, error) in
            guard let safeSelf = self else {
                return
            }
            
            if let safeError = error {
                print("Error : \(safeError)")
            }
            else {
                if let safeView = view as? SampleView4 {
                    safeSelf.adView = safeView
                    safeSelf.showAd()
                }
            }
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
        self.hideAd()
    }
    
}

// MARK: UITableViewDataSource
extension NativeAdSample6ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        cell.textLabel?.text = "index : \(indexPath.row)"
        return cell
    }
    
}

// MARK: Private Instance Method
extension NativeAdSample6ViewController {

    private func loadNativaAd() {
        self.nativeAd.testMode = true
        self.nativeAd.apiKey = "YOUR API KEY HERE"
        self.nativeAd.delegate = self
        self.nativeAd.loadAd()
    }
    
    private func showAd() {
        if let safeAdView = self.adView where !self.adShowing {
            self.adShowing = true
            
            let width = CGRectGetWidth(UIScreen.mainScreen().bounds)
            let height = (self.nativeAd.mediaSize.height / self.nativeAd.mediaSize.width) * width
            let adWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: width, height: 0))
            adWindow.addSubview(safeAdView)
            adWindow.makeKeyAndVisible()
            
            // autolayout 設定, 與 adWindow 等大, 水平垂直置中
            safeAdView.translatesAutoresizingMaskIntoConstraints = false
            adWindow.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .Width, relatedBy: .Equal, toItem: adWindow, attribute: .Width, multiplier: 1.0, constant: 0))
            adWindow.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .Height, relatedBy: .Equal, toItem: adWindow, attribute: .Height, multiplier: 1.0, constant: 0))
            
            adWindow.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .CenterX, relatedBy: .Equal, toItem: adWindow, attribute: .CenterX, multiplier: 1.0, constant: 0))
            adWindow.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .CenterY, relatedBy: .Equal, toItem: adWindow, attribute: .CenterY, multiplier: 1.0, constant: 0))
            adWindow.layoutIfNeeded()
            self.adWindow = adWindow
            
            UIView.animateWithDuration(0.5, animations: { [weak self] in
                guard
                    let safeSelf = self,
                    let safeWindow = safeSelf.adWindow else {
                    return
                }
                
                safeWindow.frame = CGRect(x: 0, y: 0, width: width, height: height)
                safeWindow.layoutIfNeeded()
                
                var newFrame = UIScreen.mainScreen().bounds
                newFrame.origin.y = height
                newFrame.size.height -= height
                safeSelf.view.window?.frame = newFrame
            })
        }
    }
    
    private func hideAd() {
        if self.adShowing {
            self.adShowing = false
            self.nativeAd.performSelector(#selector(VANativeAd.loadAd), withObject: nil, afterDelay: 3.0)
            
            let width = CGRectGetWidth(UIScreen.mainScreen().bounds)
            UIView.animateWithDuration(0.5, animations: { [weak self] in
                
                guard
                    let safeSelf = self,
                    let safeWindow = safeSelf.adWindow else {
                    return
                }
                
                safeWindow.frame = CGRect(x: 0, y: 0, width: width, height: 0)
                safeWindow.layoutIfNeeded()
                
                safeSelf.view.window?.frame = UIScreen.mainScreen().bounds
            }, completion: { [weak self] (finished) in
                
                guard
                    let safeSelf = self,
                    let safeWindow = safeSelf.adWindow else {
                        return
                }
                
                safeWindow.subviews.forEach({ (subview) in
                    subview.removeFromSuperview()
                })
                safeWindow.hidden = true
                safeSelf.adWindow = nil
                safeSelf.view.window?.makeKeyAndVisible()
            })
        }
    }
    
}

// MARK: Life Cycle
class NativeAdSample6ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let nativeAd = VANativeAd(placement: "VMFiveAdNetwork_NativeAdSample6", adType: kVAAdTypeVideoCard)
    private var adView: UIView?
    private var adWindow: UIWindow?
    private var adShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NativeAdSample6"
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.loadNativaAd()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if self.adShowing {
            self.hideAd()
        }
        else {
            self.nativeAd.unloadAd()
        }
        NSObject.cancelPreviousPerformRequestsWithTarget(self.nativeAd, selector: #selector(VANativeAd.loadAd), object: nil)
    }
    
}
