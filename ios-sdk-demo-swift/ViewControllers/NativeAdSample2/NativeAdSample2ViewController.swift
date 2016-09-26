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
    
    func nativeAdDidLoad(_ nativeAd: VANativeAd) {
        var render: VANativeAdViewRender
        if let safeAdView = self.adView {
            render = VANativeAdViewRender(nativeAd: nativeAd, customAdView: safeAdView)
        }
        else {
            render = VANativeAdViewRender(nativeAd: nativeAd, customizedAdViewClass: SampleView2.self)
        }
        
        render.render { [weak self] (view, error) in
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
    }
    
}

// MARK: UITableViewDataSource
extension NativeAdSample2ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count + self.isAdReadyIntValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        if let safeAdView = self.adView, self.isAdReady && indexPath.row == 0 {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isAdReady && indexPath.row == 0 {
            self.showAd()
        }
        else {
            let alert = UIAlertController(title: "點到了", message: self.titles[indexPath.row - self.isAdReadyIntValue], preferredStyle: .alert)
            let action = UIAlertAction(title: "確定", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

// MARK: Private Instance Method
extension NativeAdSample2ViewController {
    
    fileprivate func showAd() {
        if let safeAdView = self.adView {
            self.view.addSubview(safeAdView)
            
            // autolayout 設定, 固定大小, 水平垂直置中
            safeAdView.translatesAutoresizingMaskIntoConstraints = false
            safeAdView.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: safeAdView.bounds.width))
            safeAdView.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: safeAdView.bounds.height))
            
            self.view.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0))
            self.view.layoutIfNeeded()
            
            safeAdView.transform = CGAffineTransform.identity.scaledBy(x: 0, y: 0)
            UIView.animate(withDuration: 0.15, animations: { [weak self] in
                guard let safeSelf = self else {
                    return
                }
                safeSelf.adView?.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
            }) { [weak self] (finished) in
                UIView.animate(withDuration: 0.15, animations: { [weak self] in
                    guard let safeSelf = self else {
                        return
                    }
                    safeSelf.adView?.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
                }, completion:nil)
            }
        }
    }
    
    fileprivate func hideAd() {
        UIView.animate(withDuration: 0.15, animations: { [weak self] in
            guard let safeSelf = self else {
                return
            }
            safeSelf.adView?.transform = CGAffineTransform.identity.scaledBy(x: 1.2, y: 1.2)
        }) { [weak self] (finished) in
            UIView.animate(withDuration: 0.15, animations: { [weak self] in
                guard let safeSelf = self else {
                    return
                }
                safeSelf.adView?.transform = CGAffineTransform.identity.scaledBy(x: 0.2, y: 0.2);
            }, completion: { [weak self] (finished) in
                guard let safeSelf = self else {
                    return
                }
                safeSelf.adView?.removeFromSuperview()
                safeSelf.nativeAd.load()
            })
        }
    }
    
}

// MARK: Life Cycle
class NativeAdSample2ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    fileprivate let nativeAd = VANativeAd(placement: "VMFiveAdNetwork_NativeAdSample2", adType: kVAAdTypeVideoCard)
    fileprivate var adView: SampleView2?
    fileprivate var isAdReady = false
    fileprivate var isAdReadyIntValue: Int {
        return (self.isAdReady == false ? 0 : 1)
    }
    fileprivate let titles = [ "第四集", "第三集", "第二集", "第一集" ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NativeAdSample2"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.nativeAd.testMode = true;
        self.nativeAd.apiKey = "YOUR API KEY HERE";
        self.nativeAd.delegate = self;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.nativeAd.load()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.nativeAd.unload()
    }

}
