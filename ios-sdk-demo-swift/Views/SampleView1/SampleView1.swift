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
    
    func nativeMainImageView() -> UIImageView {
        return self.mainImageView
    }
    
}

// MARK: Life Cycle
class SampleView1: UIView {
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!

}
