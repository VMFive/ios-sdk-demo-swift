//
//  MoPubNativeAdSampleViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/6/23.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: MPNativeAdDelegate
extension MoPubNativeAdSampleViewController: MPNativeAdDelegate {
    
    func willLeaveApplication(from nativeAd: MPNativeAd) {
        print("\(#function)")
    }
    
    func didDismissModalForNativeAd(nativeAd: MPNativeAd) {
        print("\(#function)")
    }
    
    func willLeaveApplicationFromNativeAd(nativeAd: MPNativeAd) {
        print("\(#function)")
    }
    
    func viewControllerForPresentingModalView() -> UIViewController {
        return self
    }
    
}

// MARK: Private Instance Method
extension MoPubNativeAdSampleViewController {
    
    func displayAd() {
        if
            let safeNativeAd = self.nativeAd,
            let safeAdView = try? safeNativeAd.retrieveAdView() {
            self.view.addSubview(safeAdView)
            
            // autolayout 設定, 固定大小, 水平垂直置中
            safeAdView.translatesAutoresizingMaskIntoConstraints = false
            safeAdView.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300))
            safeAdView.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 313))
            self.view.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1.0, constant: 0))
            self.view.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1.0, constant: 0))
            self.view.layoutIfNeeded()
        }
    }
    
}

// MARK: Life Cycle
class MoPubNativeAdSampleViewController: UIViewController {
    
    var nativeAd: MPNativeAd?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Video configuration.
        // REMEMBER ADD "VMFiveNativeVideoCustomEvent" IN METHOD "rendererConfigurationWithRendererSettings:" AT "MOPUBNativeVideoAdRenderer.m"
        let nativeVideoAdSettings: MOPUBNativeVideoAdRendererSettings = MOPUBNativeVideoAdRendererSettings()
        nativeVideoAdSettings.renderingViewClass = MPNativeVideoView.self
        nativeVideoAdSettings.viewSizeHandler = { (maximumWidth: CGFloat) -> CGSize in
            return CGSize(width: maximumWidth, height: 312.0)
        }
        let nativeVideoConfig: MPNativeAdRendererConfiguration = MOPUBNativeVideoAdRenderer.rendererConfiguration(with: nativeVideoAdSettings)
        
        let adRequest: MPNativeAdRequest = MPNativeAdRequest(adUnitIdentifier: "7091c47489aa4796a44ff0802098adb8", rendererConfigurations: [nativeVideoConfig])
        adRequest.start(completionHandler: { (request, response, error) -> Void in
            
            if error != nil {
                print("================> \(error)")
            }
            else {
                response?.delegate = self
                self.nativeAd = response
                self.displayAd()
                print("Received Native Ad")
            }
        })
    }

}
