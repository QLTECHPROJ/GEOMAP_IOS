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
    
    func addInitialsImage(text : String) {
        DispatchQueue.main.async {
            let initials = UILabel(frame: self.frame)
            
            initials.layer.cornerRadius = self.frame.height / 2
            
            initials.center = CGPoint(x: self.bounds.width / 2 , y: self.bounds.height / 2)
            
            initials.textAlignment = .center
            initials.font = UIFont.applyCustomFont(fontName: .InterBold, fontSize: 30)
            
            var str : String = ""
            let nameArr = text.components(separatedBy: " ")
            let firstWord = nameArr.first
            let lastWord = nameArr.last
            
            if let _ = firstWord, let ch = firstWord!.first{
                str.append(ch)
            }
            if nameArr.count > 1, let _ = lastWord,let ch = lastWord!.first{
                str.append(ch)
            }
            initials.text = str
            initials.textColor = .white
            initials.backgroundColor = .colorSkyBlue
            
            self.addSubview(initials)
            
        }
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


extension UIImage{
    
    
    func resizeImage(targetSize: CGSize) -> UIImage? {
        let size = self.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    /*
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }*/
}
