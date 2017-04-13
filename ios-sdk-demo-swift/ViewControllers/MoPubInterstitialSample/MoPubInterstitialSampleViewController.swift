//
//  MoPubInterstitialSampleViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/6/23.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

extension MoPubInterstitialSampleViewController: MPInterstitialAdControllerDelegate {
    
    func interstitialDidLoadAd(_ interstitial: MPInterstitialAdController!) {
        print("\(#function)")
        interstitial.show(from: self)
    }
    
    func interstitialDidFail(toLoadAd interstitial: MPInterstitialAdController!) {
        print("\(#function)")
    }
    
    func interstitialDidDisappear(_ interstitial: MPInterstitialAdController!) {
        print("\(#function)")
        if let safeNavigation = self.navigationController {
            safeNavigation.popViewController(animated: true)
        }
        MPInterstitialAdController.removeSharedInterstitialAdController(interstitial)
    }
    
}

// MARK: Life Cycle
class MoPubInterstitialSampleViewController: UIViewController {
    
    fileprivate let interstitial = MPInterstitialAdController(forAdUnitId: "a50ce0f6fe844a78b7dfec85680ad603")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate the interstitial using the class convenience method.
        self.interstitial?.delegate = self
        
        // Fetch the interstitial ad.
        self.interstitial?.loadAd()
    }

}
