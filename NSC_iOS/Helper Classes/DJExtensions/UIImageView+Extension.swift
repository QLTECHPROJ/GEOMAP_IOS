//
//  UIImageView+Extension.swift
//

import Foundation
import UIKit
import Photos

extension UIImageView {
    /**
     Creates a new image from a URL with optional caching. If cached, the cached image is returned. Otherwise, a place holder is used until the image from web is returned by the closure.
     
     - Parameter url: The image URL.
     - Parameter placeholder: The placeholder image.
     - Parameter shouldCacheImage: Weather or not we should cache the NSURL response (default: true)
     - Parameter closure: Returns the image from the web the first time is fetched.
     
     - Returns A new image
     */
    func imageFromURL(_ url: String, placeholder: UIImage? = nil, shouldCacheImage: Bool = true, closure: ((_ image: UIImage?) -> ())? = nil ) -> UIImage?
    {
        if shouldCacheImage {
            if sharedCache.object(forKey: url as AnyObject) != nil {
                self.image = sharedCache.object(forKey: url as AnyObject) as? UIImage
                if let closure = closure {
                    closure(self.image)
                }
                return self.image
            }
        }
        return placeholder
    }
    
    func fetchImage(asset: PHAsset, contentMode: PHImageContentMode, targetSize: CGSize) {
        let options = PHImageRequestOptions()
        options.version = .original
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: contentMode, options: options) { image, _ in
            guard let image = image else { return }
            switch contentMode {
            case .aspectFill:
                self.contentMode = .scaleAspectFill
            case .aspectFit:
                self.contentMode = .scaleAspectFit
            @unknown default:
                self.contentMode = .scaleAspectFill
            }
            self.image = image
        }
    }
    
    func setImgWebUrl(imageString : String,isUserplaceholder : Bool = false){
    
        self.contentMode = .scaleAspectFill
        var placeholderImage = UIImage()
        
        if isUserplaceholder{
           placeholderImage = UIImage(named: "default_profile")!
        }
        self.sd_setImage(with: imageString.url(), placeholderImage: placeholderImage ?? nil)
    }
}

extension PHAsset {
    func image(targetSize: CGSize, contentMode: PHImageContentMode, options: PHImageRequestOptions?) -> UIImage {
        var thumbnail = UIImage()
        let imageManager = PHCachingImageManager()
        imageManager.requestImage(for: self, targetSize: targetSize, contentMode: contentMode, options: options, resultHandler: { image, _ in
            thumbnail = image!
        })
        return thumbnail
    }
}
