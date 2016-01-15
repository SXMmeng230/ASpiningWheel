//
//  ASWCollectionViewLayout.swift
//  ASpiningWheel
//
//  Created by mac on 16/1/14.
//  Copyright © 2016年 孙晓萌. All rights reserved.
//

import UIKit

class ASWCollectionViewLayoutAttributes:UICollectionViewLayoutAttributes {
    var anchorPoint = CGPointMake(0.5, 0.5)
    var angle:CGFloat = 0 {
        didSet{
        zIndex = Int(angle * 1000000)
        transform = CGAffineTransformMakeRotation(angle)
        }
    }
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let copiedAttributes:ASWCollectionViewLayoutAttributes = super.copyWithZone(zone) as! ASWCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = anchorPoint
        copiedAttributes.angle = angle
        return copiedAttributes
    }

}
class ASWCollectionViewLayout: UICollectionViewLayout {
    
    var attributesArr = [ASWCollectionViewLayoutAttributes]()
    var itemSize: CGSize  {
        return CGSize(width:collectionView!.bounds.size.width / 2, height: 150)
    }
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItemsInSection(0) > 0 ? -CGFloat(collectionView!.numberOfItemsInSection(0)-1)*anglePerItem : 0
    }
    
    var angle: CGFloat {
        return angleAtExtreme*collectionView!.contentOffset.x/(collectionViewContentSize().width - CGRectGetWidth(collectionView!.bounds))
    }

    var radius:CGFloat = 500 {
        didSet {
         invalidateLayout()
        }
    }
    var anglePerItem:CGFloat {
     return atan(itemSize.width / radius)
    }
    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(CGFloat(collectionView!.numberOfItemsInSection(0)) * itemSize.width, CGFloat(collectionView!.bounds.height))
    }
    override class func layoutAttributesClass() -> AnyClass {
       return ASWCollectionViewLayout.self
    }
    override func prepareLayout() {
        super.prepareLayout()
        
        let centerX = collectionView!.contentOffset.x + CGRectGetWidth(collectionView!.bounds) * 0.5
        //1
        let theta = atan2(CGRectGetWidth(collectionView!.bounds) / 2.0,
            radius + (itemSize.height / 2.0) - (CGRectGetHeight(collectionView!.bounds) / 2.0))
        // 2
        var startIndex = 0
        var endIndex = collectionView!.numberOfItemsInSection(0) - 1
        // 3
        if (angle < -theta) {
            startIndex = Int(floor((-theta - angle) / anglePerItem))
        }
        // 4
        endIndex = min(endIndex, Int(ceil((theta - angle) / anglePerItem)))
        // 5
        if (endIndex < startIndex) {
            endIndex = 0
            startIndex = 0
        }

        attributesArr = (startIndex...endIndex).map({ (number) -> ASWCollectionViewLayoutAttributes in
            let attributes = ASWCollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: number, inSection: 0))
            attributes.size = itemSize
            let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
            attributes.center = CGPoint(x: centerX, y: CGRectGetMidY(collectionView!.bounds))
            attributes.angle = angle + anglePerItem * CGFloat(number)
            return attributes
        })
    }
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArr
    }
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesArr[indexPath.row]
    }

}
