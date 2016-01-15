//
//  ViewController.swift
//  ASpiningWheel
//
//  Created by mac on 16/1/14.
//  Copyright © 2016年 孙晓萌. All rights reserved.
//

import UIKit

let indentifier = "ASWCollectionCell"
class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for index in 1...14{
          images.append("\(index)")
        }
  collectionView.registerNib(UINib(nibName:"ASWCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: indentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
       return images.count
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
    
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(indentifier, forIndexPath: indexPath) as! ASWCollectionViewCell
        cell.imageView.image = UIImage(named: images[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
      return CGSizeMake(collectionView.bounds.width / 2, 150)
    }

}
