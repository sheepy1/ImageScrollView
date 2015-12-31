//
//  ImageSliderCell.swift
//  ImageSlider
//
//  Created by 杨洋 on 15/12/30.
//  Copyright © 2015年 Sheepy. All rights reserved.
//

import UIKit

class ImageSliderCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: bounds)
        //imageView.contentMode = .ScaleAspectFill
        //imageView.clipsToBounds = true
        addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
