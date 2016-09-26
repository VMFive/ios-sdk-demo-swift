//
//  AdMobBannerSampleViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/6/23.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit
import GoogleMobileAds

extension AdMobBannerSampleViewController: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView!) {
        print("\(#function)")
        
        if self.bannerView.superview == nil {
            self.view.addSubview(bannerView)
        }
        
        // autolayout 設定, 固定大小, 水平置中, 貼底
        self.bannerView.translatesAutoresizingMaskIntoConstraints = false;
        self.bannerView.addConstraint(NSLayoutConstraint(item: self.bannerView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.bannerView.bounds.width))
        self.bannerView.addConstraint(NSLayoutConstraint(item: self.bannerView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.bannerView.bounds.height))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.bannerView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.bannerView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.view.layoutIfNeeded()
    }
    
    func adView(_ bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("\(#function) \(error)")
    }
    
}

// MARK: Life Cycle
class AdMobBannerSampleViewController: UIViewController {
    
    fileprivate let bannerView = GADBannerView(adSize: kGADAdSizeBanner)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 建立Google AdMob Banner
        self.bannerView.rootViewController = self;
        
        self.bannerView.adUnitID = "ca-app-pub-4125394451256992/4139885266";
        self.bannerView.delegate = self;
        
        let request = GADRequest()
        
        // 設定測試
        // forLabel後得字串必須與後台所設定的CustomEvent Label相同
        // testMode參數為非必要（此部份可跳過），若未設定testMode，後台需設定API Key
        let extra = GADCustomEventExtras()
        extra.setExtras([ "testMode": NSNumber(value: true) ], forLabel: "VMFCustomBanner")
        request.register(extra)
        
        self.bannerView.load(request)
    }

}
