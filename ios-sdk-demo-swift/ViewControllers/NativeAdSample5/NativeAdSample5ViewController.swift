//
//  NativeAdSample5ViewController.swift
//  ios-sdk-demo-swift
//
//  Created by DaidoujiChen on 2016/6/13.
//  Copyright © 2016年 DaidoujiChen. All rights reserved.
//

import UIKit

// MARK: VANativeAdDelegate
extension NativeAdSample5ViewController: VANativeAdDelegate {
    
    func nativeAdDidLoad(_ nativeAd: VANativeAd) {
        var render: VANativeAdViewRender
        if let safeAdView = self.adView {
            render = VANativeAdViewRender(nativeAd: nativeAd, customAdView: safeAdView)
        }
        else {
            render = VANativeAdViewRender(nativeAd: nativeAd, customizedAdViewClass: SampleView1.self)
        }
        
        render.render { [weak self] (view, error) in
            guard let safeSelf = self else {
                return
            }
            
            if let safeError = error {
                print("Error : \(safeError)")
            }
            else {
                if let safeView = view as? SampleView1 {
                    safeSelf.adView = safeView
                }
            }
            
            safeSelf.isAdReady = (error == nil)
            safeSelf.collectionView.reloadData()
        }
    }
    
    func nativeAd(_ nativeAd: VANativeAd, didFailedWithError error: Error) {
        print("\(#function) \(error)")
    }
    
    func nativeAdDidClick(_ nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdDidFinishHandlingClick(_ nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdBeImpressed(_ nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdDidFinishImpression(_ nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
}

// MARK: UICollectionViewDataSource
extension NativeAdSample5ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titles.count + self.isAdReadyIntValue
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.isAdReady && indexPath.row == self.adAtIndex {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            cell.subviews.forEach({ (subview) in
                subview.removeFromSuperview()
            })
            self.showAdInCell(cell: cell)
            return cell
        }
        let fixIndex = (indexPath.row < adAtIndex) ? indexPath.row : indexPath.row - self.isAdReadyIntValue;
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YourCollectionViewCell", for: indexPath) as! YourCollectionViewCell
        cell.backgroundColor = UIColor.gray;
        if let safeLabel = cell.textLabel,
           let safeImageView = cell.imageView {
            safeLabel.text = self.titles[fixIndex]
            safeImageView.image = UIImage(named: "placeholder")
        }
        return cell
    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension NativeAdSample5ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width * 0.9
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
}

// MARK: Private Instance Method
extension NativeAdSample5ViewController {
    
    fileprivate func setupTitles() {
        for index in 0..<100 {
            self.titles.append("I'm index : \(index)")
        }
    }
    
    fileprivate func loadNativaAd() {
        self.nativeAd.testMode = true
        self.nativeAd.apiKey = "YOUR API KEY HERE"
        self.nativeAd.delegate = self
        self.nativeAd.load()
    }
    
    fileprivate func showAdInCell(cell: UICollectionViewCell) {
        if let safeAdView = self.adView {
            cell.addSubview(safeAdView)
            
            // autolayout 設定, 固定大小, 水平垂直置中
            safeAdView.translatesAutoresizingMaskIntoConstraints = false
            safeAdView.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: cell.bounds.width))
            safeAdView.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: cell.bounds.height))
            
            cell.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .centerX, relatedBy: .equal, toItem: cell, attribute: .centerX, multiplier: 1.0, constant: 0))
            cell.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .centerY, relatedBy: .equal, toItem: cell, attribute: .centerY, multiplier: 1.0, constant: 0))
            cell.layoutIfNeeded()
        }
    }
}

// MARK: Life Cycle
class NativeAdSample5ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var titles: [String] = []
    fileprivate let nativeAd = VANativeAd(placement: "VMFiveAdNetwork_NativeAdSample5", adType: kVAAdTypeVideoCard)
    fileprivate var adView: SampleView1?
    fileprivate var isAdReady = false
    fileprivate var isAdReadyIntValue: Int {
        return (self.isAdReady == false ? 0 : 1)
    }
    fileprivate let adAtIndex = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NativeAdSample5"
        self.setupTitles()
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        self.collectionView.register(UINib(nibName: "YourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "YourCollectionViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadNativaAd()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.nativeAd.unload()
    }
    
}
