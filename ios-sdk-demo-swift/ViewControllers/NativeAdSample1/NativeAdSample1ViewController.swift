//
//  NativeAdSample1ViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/5/31.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VANativeAdDelegate
extension NativeAdSample1ViewController: VANativeAdDelegate {
    
    func nativeAdDidLoad(_ nativeAd: VANativeAd) {
        if let safeAdView = self.adView as? UIView & VANativeAdViewRenderProtocol {
            
            // AdView存在時，可以直接將AdView帶入進行Rendering
            let render = VANativeAdViewRender(nativeAd: nativeAd, customAdView: safeAdView)
            
            // 清除AdView上廣告素材並重新Rendering
            render.render(completeHandler: { (view, error) in
                if let safeError = error {
                    print("Render did fail With error : \(safeError)")
                }
            })
        }
        else {
            let render = VANativeAdViewRender(nativeAd: nativeAd, customizedAdViewClass: SampleView1.self)
            render.render(completeHandler: { [weak self] (view, error) in
                guard let safeSelf = self else {
                    return
                }
                
                if let safeError = error {
                    print("Render did fail With error : \(safeError)")
                }
                else if let safeView = view {
                    safeSelf.view.addSubview(safeView)
                    
                    // autolayout 設定, 固定大小, 水平垂直置中
                    safeView.translatesAutoresizingMaskIntoConstraints = false
                    safeView.addConstraint(NSLayoutConstraint(item: safeView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: safeView.bounds.width))
                    safeView.addConstraint(NSLayoutConstraint(item: safeView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: safeView.bounds.height))
                    
                    safeSelf.view.addConstraint(NSLayoutConstraint(item: safeView, attribute: .centerX, relatedBy: .equal, toItem: safeSelf.view, attribute: .centerX, multiplier: 1.0, constant: 0))
                    safeSelf.view.addConstraint(NSLayoutConstraint(item: safeView, attribute: .centerY, relatedBy: .equal, toItem: safeSelf.view, attribute: .centerY, multiplier: 1.0, constant: 0))
                    safeSelf.view.layoutIfNeeded()
                    
                    safeSelf.adView = safeView
                }
            })
        }
    }
    
    func nativeAd(_ nativeAd: VANativeAd, didFailedWithError error: Error) {
        print("\(#function) \(error)")
    }
    
    func nativeAdDidClick(_ nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdDidFinishHandlingClick(_ nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdBeImpressed(_ nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdDidFinishImpression(_ nativeAd: VANativeAd) {
        print("\(#function)")
        
        // 當影片播放完畢時, 加入這行可以取得下一則影音廣告
        nativeAd.load()
    }
    
}

// MARK: Life Cycle
class NativeAdSample1ViewController: UIViewController {
    
    fileprivate let nativeAd = VANativeAd(placement: "VMFiveAdNetwork_NativeAdSample1", adType:kVAAdTypeVideoCard)
    fileprivate var adView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NativeAdSample1"
        
        // 建立NativeAd物件做為Render的Ad資料來源
        self.nativeAd.testMode = true
        self.nativeAd.apiKey = "YOUR API KEY HERE"
        self.nativeAd.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.nativeAd.load()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.nativeAd.unload()
    }

}
