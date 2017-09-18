//
//  MoPubSplashSampleViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2017/9/18.
//  Copyright © 2017年 DaidoujiChen. All rights reserved.
//

import UIKit

extension MoPubSplashSampleViewController: MPInterstitialAdControllerDelegate {
    
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

class MoPubSplashSampleViewController: UIViewController {
    
    fileprivate let interstitial = MPInterstitialAdController(forAdUnitId: "b8f73dc866f741a3bb305d9723d3db47")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instantiate the splash using the class convenience method.
        self.interstitial?.delegate = self
        
        // Fetch the splash ad.
        self.interstitial?.loadAd()
    }
    
}
