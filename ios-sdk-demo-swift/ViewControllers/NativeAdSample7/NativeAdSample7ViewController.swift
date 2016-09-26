//
//  NativeAdSample7ViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/6/30.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VANativeAdDelegate
extension NativeAdSample7ViewController: VANativeAdDelegate {
    
    func nativeAdDidLoad(_ nativeAd: VANativeAd) {
        print("\(#function)")

        let render: VANativeAdViewRender = VANativeAdViewRender(nativeAd: nativeAd, customizedAdViewClass: SampleView3.self)
        render.render(completeHandler: { [weak self] (view, error) -> Void in
            guard let safeSelf = self else {
                return
            }
            
            if let safeError = error {
                print("Error : \(safeError)")
            }
            else {
                if let safeView = view as? SampleView3 {
                    safeView.frame = safeSelf.adContainView.bounds
                    safeSelf.adContainView.addSubview(safeView)
                    safeSelf.adView = safeView
                }
            }
        })
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
    }
    
}

// MARK: Private Instance Method
extension NativeAdSample7ViewController {
    
    fileprivate func loadNativaAd() {
        self.nativeAd.testMode = true
        self.nativeAd.apiKey = "YOUR API KEY HERE"
        self.nativeAd.delegate = self
        self.nativeAd.load()
    }
    
}

// MARK: Life Cycle
class NativeAdSample7ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var adContainView: UIView!
    fileprivate let nativeAd = VANativeAd(placement: "VMFiveAdNetwork_NativeAdSample7", adType: kVAAdTypeVideoCard)
    fileprivate var adView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NativeAdSample7"
        
        // init values
        self.imageView.image = UIImage(named: "placeholder")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadNativaAd()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = UIScreen.main.bounds.width
        let height = self.adContainView.frame.maxY + 10
        self.scrollView.contentSize = CGSize(width: width, height: height)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.nativeAd.unload()
    }

}
