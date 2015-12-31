//
//  ImageSliderView.swift
//  ImageSlider
//
//  Created by 杨洋 on 15/12/30.
//  Copyright © 2015年 Sheepy. All rights reserved.
//

import UIKit

class ImageSliderView: UIView {
    
    /**
     必须设置一个强引用的属性sliderDataSorce，
     不能直接cellectionView.dataSource ＝ ImageSliderDataSource()，
     因为dataSource是个weak属性，
     所以可能会提前释放ImageSliderDataSource对象导致不能正常显示Cell。
     */
    lazy var sliderDelegate = ImageSliderDelegate()
    
    lazy var layout: UICollectionViewLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.scrollDirection = .Horizontal
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: self.layout)
        collectionView.pagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerClass(ImageSliderCell.self, forCellWithReuseIdentifier: CellReuseId.SliderId)
        self.sliderDelegate.pageCtrl = self.pageCtrl
        collectionView.dataSource = self.sliderDelegate
        return collectionView
    }()
    
    
    lazy var pageCtrl: UIPageControl = {
        let width = self.bounds.width/5
        let height = 15 as CGFloat
        let x = self.bounds.width/2 - width/2
        let y = self.bounds.height - height * 2
        let pageCtrl = UIPageControl(frame: CGRect(x: x, y: y, width: width, height: height))
        return pageCtrl
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        addSubview(pageCtrl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("ImageSliderView is released.")
    }
    
    
}

struct CellReuseId {
    static let SliderId = "Slider"
}