//
//  AdMobInterstitialSampleViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/6/23.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit
import GoogleMobileAds

extension AdMobInterstitialSampleViewController: GADInterstitialDelegate {
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial!) {
        print("\(#function)")
        ad.present(fromRootViewController: self)
    }
    
    func interstitial(_ ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("\(#function) \(error)")
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial!) {
        print("\(#function)")
        if let safeNavigation = self.navigationController {
            safeNavigation.popViewController(animated: true)
        }
    }
    
}

// MARK: Life Cycle
class AdMobInterstitialSampleViewController: UIViewController {
    
    fileprivate let interstitial = GADInterstitial(adUnitID: "ca-app-pub-4125394451256992/6223564062")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 建立Google AdMob Interstitial
        self.interstitial.delegate = self
        let request = GADRequest()
        
        // 設定測試
        // Label必須與後台所設定的CustomEvent Label相同
        // testMode參數為非必要（此部份可跳過），若未設定testMode，後台需設定API Key
        let extra = GADCustomEventExtras()
        extra.setExtras([ "testMode": NSNumber(value: true) ], forLabel: "VMFCustomInterstitial")
        request.register(extra)
        self.interstitial.load(request)
    }

}
