//
//  SampleView4.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/6/20.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VANativeAdViewRenderProtocol
extension SampleView4: VANativeAdViewRenderProtocol {
    
    static func nibForAd() -> UINib {
        return UINib.init(nibName: "SampleView4", bundle: nil)
    }
    
    func nativeVideoView() -> UIView {
        return self.videoView
    }
    
}

// MARK: Life Cycle
class SampleView4: UIView {
    
    @IBOutlet weak var videoView: UIView!

}
