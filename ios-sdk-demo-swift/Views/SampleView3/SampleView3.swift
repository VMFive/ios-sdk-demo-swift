//
//  SampleView3.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/5/31.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VANativeAdViewRenderProtocol
extension SampleView3: VANativeAdViewRenderProtocol {
    
    func nativeVideoView() -> UIView {
        return self.videoView ?? UIView()
    }
    
    func nativeIconImageView() -> UIImageView {
        return self.iconImageView ?? UIImageView()
    }
    
    func nativeTitleTextLabel() -> UILabel {
        return self.titleLabel ?? UILabel()
    }
    
    func clickableViews() -> [AnyObject] {
        if let safeCtaButton = self.ctaButton {
            return [ safeCtaButton ]
        }
        else {
            return []
        }
    }
    
}

// MARK: Private Instance Method
extension SampleView3 {
    
    private func defaultAutoresizingMask() -> UIViewAutoresizing {
        return [ .FlexibleWidth, .FlexibleHeight, .FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleLeftMargin, .FlexibleRightMargin ]
    }
    
    private func defaultLayout() {
        self.autoresizingMask = self.defaultAutoresizingMask()
        
        let videoView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 180))
        videoView.autoresizingMask = self.defaultAutoresizingMask()
        self.addSubview(videoView)
        self.videoView = videoView
        
        let iconImageView = UIImageView(frame: CGRect(x: 0, y: 180, width: 30, height: 30))
        iconImageView.autoresizingMask = self.defaultAutoresizingMask();
        self.addSubview(iconImageView)
        self.iconImageView = iconImageView;
        
        let titleLabel = UILabel(frame: CGRect(x: 30, y: 180, width: 200, height: 30))
        titleLabel.autoresizingMask = self.defaultAutoresizingMask();
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel
        
        let ctaButton = UIButton(type: .Custom)
        ctaButton.frame = CGRect(x: 230, y: 180, width: 90, height: 30)
        ctaButton.autoresizingMask = self.defaultAutoresizingMask()
        ctaButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        ctaButton.titleLabel?.textColor = UIColor.whiteColor()
        ctaButton.backgroundColor = UIColor.blackColor()
        ctaButton.setTitle("了解更多", forState: .Normal)
        self.addSubview(ctaButton)
        self.ctaButton = ctaButton;
    }
    
}

// MARK: Life Cycle
class SampleView3: UIView {
    
    var videoView: UIView?
    var iconImageView: UIImageView?
    var titleLabel: UILabel?
    var ctaButton: UIButton?
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 320, height: 210))
        self.defaultLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
