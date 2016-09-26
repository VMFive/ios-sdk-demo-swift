//
//  SampleView2.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/5/31.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VANativeAdViewRenderProtocol
extension SampleView2: VANativeAdViewRenderProtocol {
    
    static func nibForAd() -> UINib {
        return UINib(nibName: "SampleView2", bundle: nil)
    }
    
    func nativeTitleTextLabel() -> UILabel {
        return self.titleLabel
    }
    
    func nativeVideoView() -> UIView {
        return self.videoView
    }
    
    func clickableViews() -> [Any] {
        return [ self.ctaLabel ]
    }
    
}

// MARK: Life Cycle
class SampleView2: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var ctaLabel: UILabel!
    
    @IBAction func closeAction(_ sender: AnyObject) {
        if let safeOnClose = self.onClose {
            safeOnClose()
        }
    }
    
    var onClose: (() -> Void)?
    
}
