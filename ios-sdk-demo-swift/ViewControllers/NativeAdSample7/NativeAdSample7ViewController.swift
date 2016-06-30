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
    
    func nativeAdDidLoad(nativeAd: VANativeAd) {
        print("\(#function)")

        let render: VANativeAdViewRender = VANativeAdViewRender(nativeAd: nativeAd, customizedAdViewClass: SampleView3.self)
        render.renderWithCompleteHandler({ [weak self] (view, error) -> Void in
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
    
    func nativeAd(nativeAd: VANativeAd, didFailedWithError error: NSError) {
        print("\(#function) \(error)")
    }
    
    func nativeAdDidClick(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdDidFinishHandlingClick(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdBeImpressed(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdDidFinishImpression(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
}

// MARK: Private Instance Method
extension NativeAdSample7ViewController {
    
    private func loadNativaAd() {
        self.nativeAd.testMode = true
        self.nativeAd.apiKey = "YOUR API KEY HERE"
        self.nativeAd.delegate = self
        self.nativeAd.loadAd()
    }
    
}

// MARK: Life Cycle
class NativeAdSample7ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var adContainView: UIView!
    private let nativeAd = VANativeAd(placement: "VMFiveAdNetwork_NativeAdSample7", adType: kVAAdTypeVideoCard)
    private var adView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NativeAdSample7"
        
        // init values
        self.imageView.image = UIImage(named: "placeholder")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadNativaAd()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = CGRectGetWidth(UIScreen.mainScreen().bounds)
        let height = CGRectGetMaxY(self.adContainView.frame) + 10
        self.scrollView.contentSize = CGSize(width: width, height: height)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.nativeAd.unloadAd()
    }

}
