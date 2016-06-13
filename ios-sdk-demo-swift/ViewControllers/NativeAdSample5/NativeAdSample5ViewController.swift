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
    
    func nativeAdDidLoad(nativeAd: VANativeAd) {
        var render: VANativeAdViewRender
        if let safeAdView = self.adView {
            render = VANativeAdViewRender(nativeAd: nativeAd, customAdView: safeAdView)
        }
        else {
            render = VANativeAdViewRender(nativeAd: nativeAd, customizedAdViewClass: SampleView1.self)
        }
        
        render.renderWithCompleteHandler { [weak self] (view, error) in
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
    
    func nativeAd(nativeAd: VANativeAd, didFailedWithError error: NSError) {
        print("\(#function) \(error)")
    }
    
    func nativeAdDidClick(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdDidFinishHandlingClick(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdBeImpressed(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
    func nativeAdDidFinishImpression(nativeAd: VANativeAd) {
        print("\(#function)")
    }
    
}

// MARK: UICollectionViewDataSource
extension NativeAdSample5ViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titles.count + self.isAdReadyIntValue
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if self.isAdReady && indexPath.row == self.adAtIndex {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("UICollectionViewCell", forIndexPath: indexPath)
            cell.subviews.forEach({ (subview) in
                subview.removeFromSuperview()
            })
            self.showAdInCell(cell)
            return cell
        }
        let fixIndex = (indexPath.row < adAtIndex) ? indexPath.row : indexPath.row - self.isAdReadyIntValue;
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("YourCollectionViewCell", forIndexPath: indexPath) as! YourCollectionViewCell
        cell.backgroundColor = UIColor.grayColor();
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellWidth = CGRectGetWidth(UIScreen.mainScreen().bounds) * 0.9
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
}

// MARK: Private Instance Method
extension NativeAdSample5ViewController {
    
    private func setupTitles() {
        for index in 0..<100 {
            self.titles.append("I'm index : \(index)")
        }
    }
    
    private func loadNativaAd() {
        self.nativeAd.testMode = true
        self.nativeAd.apiKey = "YOUR API KEY HERE"
        self.nativeAd.delegate = self
        self.nativeAd.loadAd()
    }
    
    private func showAdInCell(cell: UICollectionViewCell) {
        if let safeAdView = self.adView {
            cell.addSubview(safeAdView)
            
            // autolayout 設定, 固定大小, 水平垂直置中
            safeAdView.translatesAutoresizingMaskIntoConstraints = false
            safeAdView.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGRectGetWidth(cell.bounds)))
            safeAdView.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1.0, constant: CGRectGetHeight(cell.bounds)))
            
            cell.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .CenterX, relatedBy: .Equal, toItem: cell, attribute: .CenterX, multiplier: 1.0, constant: 0))
            cell.addConstraint(NSLayoutConstraint(item: safeAdView, attribute: .CenterY, relatedBy: .Equal, toItem: cell, attribute: .CenterY, multiplier: 1.0, constant: 0))
            cell.layoutIfNeeded()
        }
    }
}

// MARK: Life Cycle
class NativeAdSample5ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var titles: [String] = []
    private let nativeAd = VANativeAd(placement: "VMFiveAdNetwork_NativeAdSample5", adType: kVAAdTypeVideoCard)
    private var adView: SampleView1?
    private var isAdReady = false
    private var isAdReadyIntValue: Int {
        return (self.isAdReady == false ? 0 : 1)
    }
    private let adAtIndex = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "NativeAdSample5"
        self.setupTitles()
        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        self.collectionView.registerNib(UINib(nibName: "YourCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "YourCollectionViewCell")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.loadNativaAd()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.nativeAd.unloadAd()
    }
    
}
