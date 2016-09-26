//
//  SampleView1.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/5/30.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VANativeAdViewRenderProtocol
extension SampleView1: VANativeAdViewRenderProtocol {
    
    static func nibForAd() -> UINib {
        return UINib.init(nibName: "SampleView1", bundle: nil)
    }
    
    func nativeVideoView() -> UIView {
        return self.videoView
    }
    
    func nativeTitleTextLabel() -> UILabel {
        return self.titleLabel
    }
    
    func nativeCallToActionTextLabel() -> UILabel {
        return self.ctaLabel
    }
    
    func clickableViews() -> [Any] {
        return [ self.ctaButton ]
    }
    
}

// MARK: KVO
extension SampleView1 {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let safeChange = change, let newValue = safeChange[.newKey] as? String, keyPath == "ctaLabel.text" {
            self.ctaButton.setTitle(newValue, for: .normal)
        }
    }
    
}

// MARK: Life Cycle
class SampleView1: UIView {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ctaButton: UIButton!
    
    let ctaLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addObserver(self, forKeyPath: "ctaLabel.text", options: .new, context: nil)
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "ctaLabel.text", context: nil)
    }
    
}
