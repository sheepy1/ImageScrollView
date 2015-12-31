//
//  ImageSliderDataSource.swift
//  ImageSlider
//
//  Created by 杨洋 on 15/12/30.
//  Copyright © 2015年 Sheepy. All rights reserved.
//

import UIKit

class ImageSliderDelegate: NSObject {
    
    weak var pageCtrl: UIPageControl!
    
    var imageList = [UIImage]()
    var imageCount: Int {
        return imageList.count
    }
    
}

extension ImageSliderDelegate: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        pageCtrl.numberOfPages = imageCount
        return imageCount
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        pageCtrl.currentPage = section
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CellReuseId.SliderId, forIndexPath: indexPath) as! ImageSliderCell
        cell.imageView.image = imageList[section]
        
        return cell
    }
}
