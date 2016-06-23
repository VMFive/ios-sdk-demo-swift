//
//  MPNativeVideoView.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/6/23.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: MPNativeAdRendering
extension MPNativeVideoView: MPNativeAdRendering {
    
    func nativeMainTextLabel() -> UILabel {
        return self.mainTextLabel
    }
    
    func nativeTitleTextLabel() -> UILabel {
        return self.titleLabel
    }
    
    func nativeCallToActionTextLabel() -> UILabel {
        return self.ctaLabel
    }
    
    func nativeIconImageView() -> UIImageView {
        return self.iconImageView
    }
    
    func nativeMainImageView() -> UIImageView {
        return self.mainImageView
    }
    
    func nativeVideoView() -> UIView {
        return self.videoView
    }
    
    func nativePrivacyInformationIconImageView() -> UIImageView {
        return self.privacyInformationIconImageView
    }
    
}

// MARK: MPNativeVideoView
class MPNativeVideoView: UIView {
    
    let titleLabel = UILabel(frame: CGRectMake(75, 10, 212, 60))
    let mainTextLabel = UILabel(frame: CGRectMake(10, 68, 300, 50))
    let iconImageView = UIImageView(frame: CGRectMake(10, 10, 60, 60))
    let mainImageView = UIImageView(frame: CGRectMake(10, 119, 300, 156))
    let videoView = UIView(frame: CGRectMake(10, 119, 300, 156))
    let ctaLabel = UILabel(frame: CGRectMake(10, 270, 300, 48))
    let privacyInformationIconImageView = UIImageView(frame: CGRectMake(290, 10, 20, 20))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 0.21, alpha: 1.0)
        self.clipsToBounds = true
        
        self.titleLabel.font = UIFont.boldSystemFontOfSize(17.0)
        self.titleLabel.text = "Title"
        self.titleLabel.textColor = UIColor(white: 0.86, alpha: 1.0)
        self.addSubview(self.titleLabel)
        
        self.mainTextLabel.font = UIFont.systemFontOfSize(14.0)
        self.mainTextLabel.text = "Text"
        self.mainTextLabel.numberOfLines = 2
        self.mainTextLabel.textColor = UIColor(white: 0.86, alpha: 1.0)
        self.addSubview(self.mainTextLabel)
        
        self.addSubview(self.iconImageView)
        
        self.mainImageView.clipsToBounds = true
        self.mainImageView.contentMode = .ScaleAspectFill
        self.addSubview(self.mainImageView)
        
        self.videoView.clipsToBounds = true
        self.videoView.contentMode = .ScaleAspectFill
        self.addSubview(self.videoView)
        
        self.ctaLabel.font = UIFont.systemFontOfSize(14.0)
        self.ctaLabel.text = "CTA Text"
        self.ctaLabel.textColor = UIColor.greenColor()
        self.ctaLabel.textAlignment = .Right
        self.addSubview(self.ctaLabel)
        
        self.addSubview(self.privacyInformationIconImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let width: CGFloat = self.bounds.size.width
        self.titleLabel.frame = CGRectMake(75, 10, 212, 60)
        self.iconImageView.frame = CGRectMake(10, 10, 60, 60)
        self.privacyInformationIconImageView.frame = CGRectMake(width - 30, 10, 20, 20)
        self.ctaLabel.frame = CGRectMake(width - 100, 270, 90, 48)
        self.mainTextLabel.frame = CGRectMake(width / 2 - 150, 68, 300, 50)
        self.mainImageView.frame = CGRectMake(width / 2 - 150, 119, 300, 156)
        self.videoView.frame = self.mainImageView.frame
    }
    
}
