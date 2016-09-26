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
    
    func nativeAdDidLoad(_ nativeAd: VANativeAd) {
        var render: VANativeAdViewRender
        if let safeAdView = self.adView {
            render = VANativeAdViewRender(nativeAd: nativeAd, customAdView: safeAdView)
        }
        else {
            render = VANativeAdViewRender(nativeAd: nativeAd, customizedAdViewClass: SampleView4.self)
        }
        
        render.render { [weak self] (view, error) in
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
    
    func nativeAd(_ nativeAd: VANativeAd, didFailedWithError error: Error) {
        print("\(#function) \(error)")
    }
    
    func nativeAdDidClick(_ nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdDidFinishHandlingClick(_ nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdBeImpressed(_ nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdDidFinishImpression(_ nativeAd: VANativeAd) {
        print("\(#function)")
        self.hideAd()
    }
    
}

// MARK: UITableViewDataSource
extension NativeAdSample6ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "index : \(indexPath.row)"
        return cell
    }
    
}

// MARK: Private Instance Method
extension NativeAdSample6ViewController {

    fileprivate func loadNativaAd() {
        self.nativeAd.testMode = true
        self.nativeAd.apiKey = "YOUR API KEY HERE"
        self.nativeAd.delegate = self
        self.nativeAd.load()
    }
    
    fileprivate func showAd() {
        if let safeAdView = self.adView, !self.adShowing {
            self.adShowing = true
            
            let width = UIScreen.main.bounds.width
            let height = (self.nativeAd.mediaSize.height / self.nativeAd.mediaSize.width) * width
            let adWindow = UIWindow(frame: CGRect(x: 0, y: 0, width: width, height: 0))
            adWindow.addSubview(safeAdView)
            adWindow.makeKeyAndVisible()
            
            // autolayout 設定, 與 adWindow 等大, 水平垂直置中
            safeAdView.translatesAutoresizingMaskIntoConstraints = false
            adWindow.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .width, relatedBy: .equal, toItem: adWindow, attribute: .width, multiplier: 1.0, constant: 0))
            adWindow.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .height, relatedBy: .equal, toItem: adWindow, attribute: .height, multiplier: 1.0, constant: 0))
            
            adWindow.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .centerX, relatedBy: .equal, toItem: adWindow, attribute: .centerX, multiplier: 1.0, constant: 0))
            adWindow.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .centerY, relatedBy: .equal, toItem: adWindow, attribute: .centerY, multiplier: 1.0, constant: 0))
            adWindow.layoutIfNeeded()
            self.adWindow = adWindow
            
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                guard
                    let safeSelf = self,
                    let safeWindow = safeSelf.adWindow else {
                    return
                }
                
                safeWindow.frame = CGRect(x: 0, y: 0, width: width, height: height)
                safeWindow.layoutIfNeeded()
                
                var newFrame = UIScreen.main.bounds
                newFrame.origin.y = height
                newFrame.size.height -= height
                safeSelf.view.window?.frame = newFrame
            })
        }
    }
    
    fileprivate func hideAd() {
        if self.adShowing {
            self.adShowing = false
            self.nativeAd.perform(#selector(VANativeAd.load), with: nil, afterDelay: 3.0)
            
            let width = UIScreen.main.bounds.width
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                
                guard
                    let safeSelf = self,
                    let safeWindow = safeSelf.adWindow else {
                    return
                }
                
                safeWindow.frame = CGRect(x: 0, y: 0, width: width, height: 0)
                safeWindow.layoutIfNeeded()
                
                safeSelf.view.window?.frame = UIScreen.main.bounds
            }, completion: { [weak self] (finished) in
                
                guard
                    let safeSelf = self,
                    let safeWindow = safeSelf.adWindow else {
                        return
                }
                
                safeWindow.subviews.forEach({ (subview) in
                    subview.removeFromSuperview()
                })
                safeWindow.isHidden = true
                safeSelf.adWindow = nil
                safeSelf.view.window?.makeKeyAndVisible()
            })
        }
    }
    
}

// MARK: Life Cycle
class NativeAdSample6ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate let nativeAd = VANativeAd(placement: "VMFiveAdNetwork_NativeAdSample6", adType: kVAAdTypeVideoCard)
    fileprivate var adView: UIView?
    fileprivate var adWindow: UIWindow?
    fileprivate var adShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NativeAdSample6"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadNativaAd()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.adShowing {
            self.hideAd()
        }
        else {
            self.nativeAd.unload()
        }
        NSObject.cancelPreviousPerformRequests(withTarget: self.nativeAd, selector: #selector(VANativeAd.load), object: nil)
    }
    
}
