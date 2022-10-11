//
//  UICollectionView+Extension.swift
//  NSC_iOS
//
//  Created by Dhruvit on 28/04/22.
//

import Foundation
import UIKit


extension UICollectionView {
    
    var lastIndex : IndexPath? {
        if numberOfItems(inSection: 0) > 0 {
            return IndexPath(item: numberOfItems(inSection: 0)-1, section: 0)
        }
        return nil
    }
    
    // MARK: - Register CollectionViewCell with ClassName
    func register<T: UICollectionViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?
        
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        
        register(UINib(nibName: identifier, bundle: bundle), forCellWithReuseIdentifier: identifier)
    }
    
    // MARK: - Dequeue CollectionViewCell with ClassName
    func dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(String(describing: name)), make sure the cell is registered with collection view")
        }
        return cell
    }
    
    func takeWholeScreenshot() -> UIImage {
        
        self.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        
        UIGraphicsBeginImageContext(self.contentSize)
        
        if let aContext = UIGraphicsGetCurrentContext() {
            self.layer.render(in: aContext)
        }
        let rows: Int = self.numberOfItems(inSection: 0)
        
        for i in 0..<rows {
            self.scrollToItem(at: IndexPath(item: i, section: 0), at: .top, animated: false)
            
            if let aContext = UIGraphicsGetCurrentContext() {
                self.layer.render(in: aContext)
            }
        }
        self.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        
        return image!
    }
    
}


class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            
            layoutAttribute.frame.origin.x = leftMargin
            
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        
        return attributes
    }
}
