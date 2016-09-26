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
    
    func rewardedVideoDidLoad(_ rewardedVideo: VAAdRewardedVideo) {
        print("\(#function)")
        rewardedVideo.show()
    }
    
    func rewardedVideoWillShow(_ rewardedVideo: VAAdRewardedVideo) {
        print("\(#function)")
    }
    
    func rewardedVideoDidShow(_ rewardedVideo: VAAdRewardedVideo) {
        print("\(#function)")
    }
    
    func rewardedVideoWillClose(_ rewardedVideo: VAAdRewardedVideo) {
        print("\(#function)")
    }
    
    func rewardedVideoDidClose(_ rewardedVideo: VAAdRewardedVideo) {
        print("\(#function)")
        if self.successRewarded {
            let alert = UIAlertController(title: "成功獲得獎勵", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "確定", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func rewardedVideoDidClick(_ rewardedVideo: VAAdRewardedVideo) {
        print("\(#function)")
    }
    
    func rewardedVideoDidFinishHandlingClick(_ rewardedVideo: VAAdRewardedVideo) {
        print("\(#function)")
    }
    
    func rewardedVideo(_ rewardedVideo: VAAdRewardedVideo, shouldReward rewarded: VAAdRewarded) {
        print("\(#function)")
        self.successRewarded = true
    }
    
    func rewardedVideo(_ rewardedVideo: VAAdRewardedVideo, didFailWithError error: Error) {
        print("\(#function) \(error)")
    }
    
    func rewardedCustomString() -> String {
        print("\(#function)")
        return "YOURCUSTOMSTRING"
    }
    
}

// MARK: Life Cycle
class RewardedVideoSampleViewController: UIViewController {

    fileprivate let rewardedVideo = VAAdRewardedVideo(placement: "VMFiveAdNetwork_RewardedVideoSample")
    fileprivate var successRewarded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rewardedVideo.testMode = true
        self.rewardedVideo.apiKey = "YOUR API KEY HERE"
        self.rewardedVideo.delegate = self
        self.rewardedVideo.loadAd()
    }

}
