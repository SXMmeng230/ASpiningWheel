//
//  ASWCollectionViewCell.swift
//  ASpiningWheel
//
//  Created by mac on 16/1/14.
//  Copyright © 2016年 孙晓萌. All rights reserved.
//

import UIKit

class ASWCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        super.applyLayoutAttributes(layoutAttributes)
        let aswAttributes = layoutAttributes as!ASWCollectionViewLayoutAttributes
        layer.anchorPoint = aswAttributes.anchorPoint
        center.y += (aswAttributes.anchorPoint.y - 0.5) * CGRectGetHeight(self.bounds)
    }
}
