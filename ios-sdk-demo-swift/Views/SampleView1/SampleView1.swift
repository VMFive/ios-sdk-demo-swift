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
    
    func clickableViews() -> [AnyObject] {
        return [ self.ctaButton ]
    }
    
}

// MARK: KVO
extension SampleView1 {
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let safeChange = change, let newValue = safeChange["new"] as? String where keyPath == "ctaLabel.text" {
            self.ctaButton.setTitle(newValue, forState: .Normal)
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
        self.addObserver(self, forKeyPath: "ctaLabel.text", options: .New, context: nil)
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "ctaLabel.text", context: nil)
    }
    
}
