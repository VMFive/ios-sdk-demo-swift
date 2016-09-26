//
//  InterstitialSampleViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/5/30.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VAAdInterstitialDelegate
extension InterstitialSampleViewController: VAAdInterstitialDelegate {
    
    func interstitialAdDidLoad(_ interstitialAd: VAAdInterstitial) {
        print("\(#function)")
        self.interstitial.showAd(from: self)
    }
    
    func interstitialAdDidClick(_ interstitialAd: VAAdInterstitial) {
        print("\(#function)")
    }
    
    func interstitialAdWillClose(_ interstitialAd: VAAdInterstitial) {
        print("\(#function)")
    }
    
    func interstitialAdDidClose(_ interstitialAd: VAAdInterstitial) {
        print("\(#function)")
        if let safeNavigationController = self.navigationController {
            safeNavigationController.popViewController(animated: true)
        }
    }
    
    func interstitialAd(_ interstitialAd: VAAdInterstitial, didFailWithError error: Error) {
        print("\(#function) \(error)")
    }
    
}

// MARK: Life Cycle
class InterstitialSampleViewController: UIViewController {
    
    fileprivate let interstitial = VAAdInterstitial(placement: "VMFiveAdNetwork_InterstitialSample", adType: kVAAdTypeVideoInterstitial)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "InterststialSample"
        self.interstitial.testMode = true;
        self.interstitial.apiKey = "YOUR API KEY HERE";
        self.interstitial.delegate = self;
        self.interstitial.loadAd()
    }

}
