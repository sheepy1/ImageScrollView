//
//  ImageDownloadHelper.swift
//  ImageScrollView
//
//  Created by 杨洋 on 15/12/31.
//  Copyright © 2015年 Sheepy. All rights reserved.
//

import UIKit

//图片缓存
let queue = dispatch_queue_create("load_image", DISPATCH_QUEUE_CONCURRENT)
let localImage = UIImage(named: "default_img")
let imageCache = NSCache()
func loadImageFrom(imagePath: String,flag: Int = -1, completion: (image: UIImage!, flag: Int) -> Void) {
    var image: UIImage?
    guard !imagePath.isEmpty else {
        return
    }
    
    let imageUrl = imagePath
    
    if let imageData = imageCache.objectForKey(imageUrl) as? NSData {
        //printLog("cache")
        image = UIImage(data: imageData)
        completion(image: image, flag: flag)
    } else {
        dispatch_async(queue) {
            guard let url = NSURL(string: imageUrl), let data = NSData(contentsOfURL: url) else {
                return
            }
            imageCache.setObject(data, forKey: imageUrl)
            dispatch_async(dispatch_get_main_queue()) {
                completion(image: UIImage(data: data), flag: flag)
            }
        }
    }
}
