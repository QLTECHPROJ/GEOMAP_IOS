//
//  UIImage+Extension.swift
//

import Foundation
import UIKit

// MARK: - UIImage Extension -
extension UIImage {
    
    var base64String : String {
        let imageData = self.jpegData(compressionQuality: 1.0)
        return imageData?.base64EncodedString() ?? ""
    }
    
    var JPEGRepresentation:Data {
        return self.jpegData(compressionQuality: 1.0)!
    }
    
    var PNGRepresentation:Data {
        return self.pngData()!
    }
    
    func createPDF() -> NSData? {
        
        let pdfData = NSMutableData()
        let pdfConsumer = CGDataConsumer(data: pdfData as CFMutableData)!
        
        var mediaBox = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        let pdfContext = CGContext(consumer: pdfConsumer, mediaBox: &mediaBox, nil)!
        
        pdfContext.beginPage(mediaBox: &mediaBox)
        pdfContext.draw(self.cgImage!, in: mediaBox)
        pdfContext.endPage()
        
        return pdfData
    }
    
    func createPDF(image:UIImage) -> NSData? {
        
        let pdfData = NSMutableData()
        let image1Rect = CGRect(x: 20, y: 20, width: self.size.width-40, height: self.size.height)
        let image2Rect = CGRect(x: 20, y: self.size.height+40, width: image.size.width-40, height: image.size.height)
        let imageRect = CGRect(x: 0, y: 0, width: self.size.width, height: image.size.height+self.size.height+60)
        
        UIGraphicsBeginPDFContextToData(pdfData, imageRect, nil)
        UIGraphicsBeginPDFPage()
        let context = UIGraphicsGetCurrentContext()
        context?.draw(self.imageRotatedByDegrees(180, flip: true).cgImage!, in: image1Rect)
        context?.draw(image.imageRotatedByDegrees(180, flip: true).cgImage!, in: image2Rect)
        UIGraphicsEndPDFContext()
        
        return pdfData
    }
    
    func getPixelColor(_ pos: CGPoint) -> UIColor {
        
        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    var normalizedImage : UIImage {
        return UIImage(cgImage: self.cgImage!, scale: self.scale, orientation: .up)
    }
    
    func imageRotatedByDegrees(_ degrees: CGFloat, flip: Bool) -> UIImage {
//        let radiansToDegrees: (CGFloat) -> CGFloat = {
//            return $0 * (180.0 / CGFloat(M_PI))
//        }
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(Double.pi)
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: CGPoint.zero, size: size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap!.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0);
        
        //   // Rotate the image context
        bitmap!.rotate(by: degreesToRadians(degrees));
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        bitmap!.scaleBy(x: yFlip, y: -1.0)
        bitmap?.draw( cgImage!, in: CGRect (x: -size.width / 2,y: -size.height / 2,width: size.width,height: size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    var fixrotation : UIImage {
        if imageOrientation == .up {
            return self
        }
        var transform: CGAffineTransform = .identity
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi / 2))
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: -CGFloat(Double.pi / 2))
        case .up, .upMirrored:
            break
        default:
            break
        }
        
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        default:
            break
        }
        let ctx: CGContext = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage!.bitsPerComponent, bytesPerRow: 0, space: cgImage!.colorSpace!, bitmapInfo: UInt32(cgImage!.bitmapInfo.rawValue))!
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            // Grr...
            ctx.draw(cgImage!, in: CGRect(x: 0,y: 0,width: size.height,height: size.width))
        default:
            ctx.draw(cgImage!, in: CGRect(x: 0,y: 0,width: size.width,height: size.height))
        }
        let cgimg: CGImage = ctx.makeImage()!
        let img: UIImage = UIImage(cgImage: cgimg)
        return img
    }
    
    func transformToFixImage() -> CGAffineTransform {
        if imageOrientation == .up {
            return .identity
        }
        
        var transform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat(Double.pi))
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat(Double.pi/2))
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat(-Double.pi/2))
            break
        case .up, .upMirrored:
            break;
        default:
            break
        }
        
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        case .up, .down, .left, .right:
            break
        default:
            break
        }
        
        return transform
    }
    
    var scaleAndRotateImage : UIImage {
        let kMaxResolution : CGFloat = UIScreen.main.bounds.width * UIScreen.main.scale

        guard let imgRef = self.cgImage else {
            return self
        }

        let width = CGFloat(imgRef.width)
        let height = CGFloat(imgRef.height)
        var transform : CGAffineTransform = CGAffineTransform.identity
        var bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        if (width > kMaxResolution || height > kMaxResolution) {
            let ratio : CGFloat = width/height
            if (ratio > 1) {
                bounds.size.width = kMaxResolution
                bounds.size.height = CGFloat(roundf(Float(bounds.size.width / ratio)))
            }
            else {
                bounds.size.height = kMaxResolution
                bounds.size.width = CGFloat(roundf(Float(bounds.size.height * ratio)))
            }
        }

        let scaleRatio = bounds.size.width / width
        let imageSize = CGSize(width: width, height: height)
        var boundHeight : CGFloat = 0
        let orientation : UIImage.Orientation = self.imageOrientation
        switch(orientation) {

        case .up: //EXIF = 1
            transform = CGAffineTransform.identity
                break;

        case .upMirrored: //EXIF = 2
            transform = transform.translatedBy(x: imageSize.width, y: 0.0)
            transform = transform.scaledBy(x: -1.0, y: 1.0)
                break;

        case .down: //EXIF = 3
            transform = transform.translatedBy(x: imageSize.width, y: imageSize.height);
            transform = transform.rotated(by: CGFloat(Double.pi))
                break;

        case .downMirrored: //EXIF = 4
            transform = transform.translatedBy(x: 0.0, y: imageSize.height);
            transform = transform.scaledBy(x: 1.0, y: -1.0);
                break;

        case .leftMirrored: //EXIF = 5
                boundHeight = bounds.size.height
                bounds.size.height = bounds.size.width;
                bounds.size.width = boundHeight
                transform = transform.translatedBy(x: imageSize.height, y: imageSize.width);
                transform = transform.scaledBy(x: -1.0, y: 1.0);
                transform = transform.rotated(by: CGFloat(3.0 * Double.pi / 2.0));
                break;

        case .left: //EXIF = 6
                boundHeight = bounds.size.height;
                bounds.size.height = bounds.size.width;
                bounds.size.width = boundHeight;
                transform = transform.translatedBy(x: 0.0, y: imageSize.width);
                transform = transform.rotated(by: CGFloat(3.0 * Double.pi / 2.0));
                break;

        case .rightMirrored: //EXIF = 7
                boundHeight = bounds.size.height;
                bounds.size.height = bounds.size.width;
                bounds.size.width = boundHeight;
                transform = CGAffineTransform(scaleX: -1.0, y: 1.0);
                transform = transform.rotated(by: CGFloat(Double.pi / 2.0));
                break;

        case .right: //EXIF = 8
                boundHeight = bounds.size.height;
                bounds.size.height = bounds.size.width;
                bounds.size.width = boundHeight;
                transform = transform.translatedBy(x: imageSize.height, y: 0.0);
                transform = transform.rotated(by: CGFloat(Double.pi / 2.0));
                break;

        default:
            break
        }

        UIGraphicsBeginImageContext(bounds.size)

        let context = UIGraphicsGetCurrentContext()

        if (orientation == UIImage.Orientation.right || orientation == UIImage.Orientation.left) {
            context!.scaleBy(x: -scaleRatio, y: scaleRatio)
            context!.translateBy(x: -height, y: 0)
        }
        else {
            context!.scaleBy(x: scaleRatio, y: -scaleRatio)
            context!.translateBy(x: 0, y: -height)
        }

        context!.concatenate(transform)

        context!.draw(imgRef, in: CGRect(x: 0, y: 0, width: width, height: height))
        
//        CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRect(x: 0, y: 0, width: width, height: height), imgRef)
        let imageCopy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return imageCopy!
    }
    
    func maskWithColor(color: UIColor) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        let rect = CGRect(origin: CGPoint.zero, size: size)

        color.setFill()
        self.draw(in: rect)

        context.setBlendMode(.sourceIn)
        context.fill(rect)

        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
        
//        guard let maskImage = cgImage else {return nil}
//
//        let width = size.width * UIScreen.main.scale
//        let height = size.height * UIScreen.main.scale
//        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
//
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
//        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
//
//        context.clip(to: bounds, mask: maskImage)
//        context.setFillColor(color.cgColor)
//        context.fill(bounds)
//
//        if let cgImage = context.makeImage() {
//            let coloredImage = UIImage(cgImage: cgImage)
//
//            return coloredImage
//        } else {
//            return nil
//        }
    }
    
}

extension CIImage {
    
    func scaleAndResize(forRect rect: CGRect, and contentMode: UIView.ContentMode) -> CIImage {
        
        let imageSize = extent.size
        
        var horizontalScale = rect.size.width / imageSize.width
        var verticalScale = rect.size.height / imageSize.height
        
        let mode = contentMode
        
        if mode == .scaleAspectFill {
            horizontalScale = max(horizontalScale, verticalScale)
            verticalScale = horizontalScale
        }else if mode == .scaleAspectFit {
            horizontalScale = max(horizontalScale, verticalScale)
            verticalScale = horizontalScale
        }
        
        return transformed(by: CGAffineTransform(scaleX: horizontalScale, y: verticalScale))
    }
}
