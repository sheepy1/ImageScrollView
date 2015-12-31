//
//  ViewController.swift
//  ImageScrollView
//
//  Created by 杨洋 on 15/12/31.
//  Copyright © 2015年 Sheepy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var imageList: [UIImage] = {
       var list = [UIImage]()
        for i in 0 ... 3 {
            list.append(UIImage(named: "hero\(i)")!)
        }
        return list
    }()
    
    let imageUrlList = [
        "http://imgsrc.baidu.com/forum/w%3D580/sign=14868b630d2442a7ae0efdade141ad95/8618367adab44aeda4a40f04b11c8701a08bfb6c.jpg",
        "http://imgsrc.baidu.com/forum/w=580/sign=5ea475604d36acaf59e096f44cd88d03/3c1c720e0cf3d7caee80092ff41fbe096b63a937.jpg",
        "http://yun.hainei.org/forum/201511/16/112151wnd00qsvtadqdnee.jpeg",
        "http://images.17173.com/2015/acg/2015/11/04/lhj1104xbkxf05s.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        let width = view.bounds.width
        let height = view.bounds.height
        
        //CollectionView 实现，不能无限轮播
        let imageSlider = ImageSliderView(frame: CGRect(x: 0, y: 0, width: width, height: height/3))
        imageSlider.sliderDelegate.imageList = imageList
        view.addSubview(imageSlider)
        
        //ScrollView 实现，无限轮播
        let autoScrollView = AutoScrollView(frame: CGRect(x: 0, y: height/2, width: width, height: height/3))
        autoScrollView.imageUrlList = imageUrlList
        view.addSubview(autoScrollView)
    }

}

