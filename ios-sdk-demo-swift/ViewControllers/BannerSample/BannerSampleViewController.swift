//
//  BannerSampleViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/5/30.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VAAdViewDelegate
extension BannerSampleViewController: VAAdViewDelegate {
    
    func adViewDidLoad(adView: VAAdView) {
        print("\(#function)")
    }
    
    func adViewBeImpressed(adView: VAAdView) {
        print("\(#function)")
    }
    
    func adView(adView: VAAdView, didFailWithError error: NSError) {
        print("\(#function) \(error)")
    }
    
    func adViewDidClick(adView: VAAdView) {
        print("\(#function)")
    }
    
    func adViewDidFinishHandlingClick(adView: VAAdView) {
        print("\(#function)")
    }
    
    func viewControllerForPresentingModalView() -> UIViewController {
        return self
    }
    
    func shouldAdViewBeReload(adView: VAAdView) -> Bool {
        return true
    }
    
}

// MARK: Life Cycle
class BannerSampleViewController: UIViewController {

    @IBOutlet weak var bannerView: VAAdView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "BannerSample"
        self.bannerView.placement = "VMFiveAdNetwork_BannerSample";
        self.bannerView.adType = kVAAdTypeVideoBanner;
        self.bannerView.testMode = true;
        self.bannerView.apiKey = "YOUR API KEY HERE";
        self.bannerView.delegate = self;
        self.bannerView.loadAd()
    }

}
