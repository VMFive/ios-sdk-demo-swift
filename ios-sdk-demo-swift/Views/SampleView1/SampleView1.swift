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

// MARK: Life Cycle
class SampleView1: UIView {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ctaButton: UIButton!
    
    @objc dynamic let ctaLabel = UILabel()
    var observer: NSKeyValueObservation?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.observer = self.ctaLabel.observe(\.text, options: [.new]) { [weak self] (_, change) in
            if let safeSelf = self, let newValue = change.newValue {
                safeSelf.ctaButton.setTitle(newValue, for: .normal)
            }
        }
    }
    
}
