//
//  AutoScrollView.swift
//  ImageScrollView
//
//  Created by 杨洋 on 15/12/31.
//  Copyright © 2015年 Sheepy. All rights reserved.
//

import UIKit

protocol ImageButtonDelegate: class {
    func imageDidTapped()
}

class AutoScrollView: UIView {

    var imageUrlList = [String]() {
        didSet {
            initImageViews()
            loadImages()
        }
    }
    
    var imageCount: Int {
        return imageUrlList.count
    }
    
    lazy var imageViewList : [UIImageView] = {
        //直接lazyImageList = [UIImageView](count: self.imageCount + 2, repeatedValue: UIImageView())的话，
        //lazyImageList中的元素都会指向同一个UIImageView实例，是不对的。必须初始化多个实例放入数组。
        var lazyImageList = [UIImageView]()
        let endIndex = self.imageCount + 2
        for i in 0 ..< endIndex {
            let imageView = UIImageView(image: localImage)
            lazyImageList.append(imageView)
        }
        return lazyImageList
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        //初始化ScrollView
        scrollView.frame = self.bounds
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        //滑动有页面翻转的感觉
        scrollView.pagingEnabled = true
        //碰到边界时不反弹
        scrollView.bounces = false
        scrollView.delegate = self
        return scrollView
    }()
    
    lazy var pageCtrl: UIPageControl = {
        let width = self.bounds.width/5
        let height = 15 as CGFloat
        let x = self.bounds.width/2 - width/2
        let y = self.bounds.height - height * 2
        let pageCtrl = UIPageControl(frame: CGRect(x: x, y: y, width: width, height: height))
        return pageCtrl
    }()
    
    lazy var imageBtn = UIButton()
    
    var width: CGFloat!
    var height: CGFloat!
    
    weak var delegate: ImageButtonDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        width = frame.width
        height = frame.height
        
        addSubview(scrollView)
        addSubview(pageCtrl)
    }
    
    deinit {
        print("ImageSlider is released.")
    }
    
    func initImageViews() {
        let imageViewCount = imageViewList.count
        scrollView.contentSize = CGSize(width: width * CGFloat(imageViewCount), height: height)
        pageCtrl.numberOfPages = imageViewCount - 2
        pageCtrl.currentPage = 0
        imageBtn.frame = CGRect(origin: CGPointZero, size: scrollView.contentSize)
        scrollView.addSubview(imageBtn)
        imageBtn.addTarget(delegate, action: "imageDidTapped", forControlEvents: .TouchUpInside)
        //初始化ImageView
        for i in 0 ..< imageViewCount {
            let imageView = imageViewList[i]
            
            imageView.frame = CGRect(x: width * CGFloat(i), y: 0, width: width, height: height)
            scrollView.addSubview(imageView)
        }
        
        scrollView.contentOffset.x = width
    }
    
    func slideByTime() {
        var page = pageCtrl.currentPage + 1
        
        if page == imageCount {
            scrollView.contentOffset.x = width
            page = 0
        } else {
            scrollView.contentOffset.x = width * CGFloat(page + 1)
        }
        
        pageCtrl.currentPage = page
    }
    
    func loadImages() {
        let count = imageUrlList.count
        for i in 0 ..< count {
            loadImageFrom(imageUrlList[i], flag: i, completion: { image, flag in
                self.imageViewList[flag+1].image = image
                switch flag {
                case 0:
                    self.imageViewList.last?.image = image
                case count - 1:
                    self.imageViewList.first?.image = image
                default:
                    break
                }
            })
        }
        
        //计时器
        NSTimer.sy_scheduledTimeerWithTimeInterval(1, repeats: true) { [weak self] in
            self?.slideByTime()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AutoScrollView: UIScrollViewDelegate {
    //速度变慢，即将停下的时候调用
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //因为可以左右滑，所以不能简单地加1，而要通过contentofff计算要滑到第几张图片
        let page = Int(scrollView.contentOffset.x / width)
        if page == 0 {
            scrollView.contentOffset.x = width * CGFloat(imageCount)
        } else if page == imageCount + 1 {
            scrollView.contentOffset.x = width
        }
        
        pageCtrl.currentPage = Int(scrollView.contentOffset.x / width) - 1
        
    }
}

