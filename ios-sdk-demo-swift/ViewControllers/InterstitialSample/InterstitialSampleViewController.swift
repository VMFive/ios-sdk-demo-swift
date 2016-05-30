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
    
    func interstitialAdDidLoad(interstitialAd: VAAdInterstitial) {
        print("\(#function)")
        self.interstitial.showAdFromViewController(self)
    }
    
    func interstitialAdDidClick(interstitialAd: VAAdInterstitial) {
        print("\(#function)")
    }
    
    func interstitialAdWillClose(interstitialAd: VAAdInterstitial) {
        print("\(#function)")
    }
    
    func interstitialAdDidClose(interstitialAd: VAAdInterstitial) {
        print("\(#function)")
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func interstitialAd(interstitialAd: VAAdInterstitial, didFailWithError error: NSError) {
        print("\(#function) \(error)")
    }
    
}

// MARK: Life Cycle
class InterstitialSampleViewController: UIViewController {
    
    private let interstitial = VAAdInterstitial(placement: "VMFiveAdNetwork_InterstitialSample", adType: kVAAdTypeVideoInterstitial)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "InterststialSample"
        self.interstitial.testMode = true;
        self.interstitial.apiKey = "YOUR API KEY HERE";
        self.interstitial.delegate = self;
        self.interstitial.loadAd()
    }

}
