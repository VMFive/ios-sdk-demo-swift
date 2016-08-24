//
//  RewardedVideoSampleViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/6/20.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VAAdRewardedVideoDelegate
extension RewardedVideoSampleViewController: VAAdRewardedVideoDelegate {
    
    func rewardedVideoDidLoad(rewardedVideo: VAAdRewardedVideo) {
        print("\(#function)")
        rewardedVideo.show()
    }
    
    func rewardedVideoWillShow(rewardedVideo: VAAdRewardedVideo) {
        print("\(#function)")
    }
    
    func rewardedVideoDidShow(rewardedVideo: VAAdRewardedVideo) {
        print("\(#function)")
    }
    
    func rewardedVideoWillClose(rewardedVideo: VAAdRewardedVideo) {
        print("\(#function)")
    }
    
    func rewardedVideoDidClose(rewardedVideo: VAAdRewardedVideo) {
        print("\(#function)")
        if self.successRewarded {
            UIAlertView(title: "成功獲得獎勵", message: nil, delegate: nil, cancelButtonTitle: "確定").show()
        }
    }
    
    func rewardedVideoDidClick(rewardedVideo: VAAdRewardedVideo) {
        print("\(#function)")
    }
    
    func rewardedVideoDidFinishHandlingClick(rewardedVideo: VAAdRewardedVideo) {
        print("\(#function)")
    }
    
    func rewardedVideo(rewardedVideo: VAAdRewardedVideo, shouldReward rewarded: VAAdRewarded) {
        print("\(#function)")
        self.successRewarded = true
    }
    
    func rewardedVideo(rewardedVideo: VAAdRewardedVideo, didFailWithError error: NSError) {
        print("\(#function) \(error)")
    }
    
    func rewardedCustomString() -> String {
        print("\(#function)")
        return "YOURCUSTOMSTRING"
    }
    
}

// MARK: Life Cycle
class RewardedVideoSampleViewController: UIViewController {

    private let rewardedVideo = VAAdRewardedVideo(placement: "VMFiveAdNetwork_RewardedVideoSample")
    private var successRewarded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rewardedVideo.testMode = true
        self.rewardedVideo.apiKey = "YOUR API KEY HERE"
        self.rewardedVideo.delegate = self
        self.rewardedVideo.loadAd()
    }

}
