//
//  SplashSampleViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2017/9/18.
//  Copyright © 2017年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VAAdSplashDelegate
extension SplashSampleViewController: VAAdSplashDelegate {
    
    func splashAdDidLoad(_ splashAd: VAAdSplash) {
        print("\(#function)")
        self.splash.showAd(from: self)
    }
    
    func splashAdDidClick(_ splashAd: VAAdSplash) {
        print("\(#function)")
    }
    
    func splashAdWillClose(_ splashAd: VAAdSplash) {
        print("\(#function)")
    }
    
    func splashAdDidClose(_ splashAd: VAAdSplash) {
        print("\(#function)")
        if let safeNavigationController = self.navigationController {
            safeNavigationController.popViewController(animated: true)
        }
    }
    
    func splashAd(_ splashAd: VAAdSplash, didFailWithError error: Error) {
        print("\(#function) \(error)")
    }
    
}

// MARK: Life Cycle
class SplashSampleViewController: UIViewController {
    
    fileprivate let splash = VAAdSplash(placement: "VMFiveAdNetwork_SplashSample", adType: kVAAdTypeVideoSplash)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SplashSample"
        self.splash.testMode = true;
        self.splash.apiKey = "YOUR API KEY HERE";
        self.splash.delegate = self;
        self.splash.loadAd()
    }
    
}
