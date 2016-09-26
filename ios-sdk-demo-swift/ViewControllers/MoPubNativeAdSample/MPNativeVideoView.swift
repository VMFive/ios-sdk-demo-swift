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
    
    let titleLabel = UILabel(frame: CGRect(x: 75, y: 10, width: 212, height: 60))
    let mainTextLabel = UILabel(frame: CGRect(x: 10, y: 68, width: 300, height: 50))
    let iconImageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 60, height: 60))
    let mainImageView = UIImageView(frame: CGRect(x: 10, y: 119, width: 300, height: 156))
    let videoView = UIView(frame: CGRect(x: 10, y: 119, width: 300, height: 156))
    let ctaLabel = UILabel(frame: CGRect(x: 10, y: 270, width: 300, height: 48))
    let privacyInformationIconImageView = UIImageView(frame: CGRect(x: 290, y: 10, width: 20, height: 20))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(white: 0.21, alpha: 1.0)
        self.clipsToBounds = true
        
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.titleLabel.text = "Title"
        self.titleLabel.textColor = UIColor(white: 0.86, alpha: 1.0)
        self.addSubview(self.titleLabel)
        
        self.mainTextLabel.font = UIFont.systemFont(ofSize: 14.0)
        self.mainTextLabel.text = "Text"
        self.mainTextLabel.numberOfLines = 2
        self.mainTextLabel.textColor = UIColor(white: 0.86, alpha: 1.0)
        self.addSubview(self.mainTextLabel)
        
        self.addSubview(self.iconImageView)
        
        self.mainImageView.clipsToBounds = true
        self.mainImageView.contentMode = .scaleAspectFill
        self.addSubview(self.mainImageView)
        
        self.videoView.clipsToBounds = true
        self.videoView.contentMode = .scaleAspectFill
        self.addSubview(self.videoView)
        
        self.ctaLabel.font = UIFont.systemFont(ofSize: 14.0)
        self.ctaLabel.text = "CTA Text"
        self.ctaLabel.textColor = UIColor.green
        self.ctaLabel.textAlignment = .right
        self.addSubview(self.ctaLabel)
        
        self.addSubview(self.privacyInformationIconImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let width: CGFloat = self.bounds.size.width
        self.titleLabel.frame = CGRect(x: 75, y: 10, width: 212, height: 60)
        self.iconImageView.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
        self.privacyInformationIconImageView.frame = CGRect(x: width - 30, y: 10, width: 20, height: 20)
        self.ctaLabel.frame = CGRect(x: width - 100, y: 270, width: 90, height: 48)
        self.mainTextLabel.frame = CGRect(x: width / 2 - 150, y: 68, width: 300, height: 50)
        self.mainImageView.frame = CGRect(x: width / 2 - 150, y: 119, width: 300, height: 156)
        self.videoView.frame = self.mainImageView.frame
    }
    
}
