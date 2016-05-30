//
//  CardSampleViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/5/30.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VAAdViewDelegate
extension CardSampleViewController: VAAdViewDelegate {
    
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
class CardSampleViewController: UIViewController {
    
    @IBOutlet weak var cardView: VAAdView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "CardSample"
        self.cardView.placement = "VMFiveAdNetwork_CardSample";
        self.cardView.adType = kVAAdTypeVideoCard;
        self.cardView.testMode = true;
        self.cardView.apiKey = "YOUR API KEY HERE";
        self.cardView.delegate = self;
        self.cardView.loadAd()
    }

}
