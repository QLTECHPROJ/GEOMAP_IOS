//
//  UITestField+Extension.swift
//


import UIKit
import Foundation


protocol BackSpaceDetectingTextFieldDelegate : UITextFieldDelegate {
    func textFieldDidDelete(textField: BackSpaceDetectingTextField, hasValue: Bool)
}

class BackSpaceDetectingTextField: UITextField {

    override func deleteBackward() {
        let currentText = self.text ?? ""
        super.deleteBackward()
        if let delegate = self.delegate as? BackSpaceDetectingTextFieldDelegate {
            delegate.textFieldDidDelete(textField: self, hasValue: !currentText.isEmpty)
        }
    }
}

extension UITextField {
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder ?? "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    @IBInspectable var placeHolderFont: UIFont? {
           get {
               return self.placeHolderFont
           }
           set {
            
               self.attributedPlaceholder = NSAttributedString(string:self.placeholder ?? "", attributes:[NSAttributedString.Key.font: newValue!])
           }
       }
    
    var isEmptyText:Bool! {
        return !(self.text!.trim.count > 0)
    }
    
    func errorMessageView() -> LNErrorMessageView? {
        return (self.rightView is LNErrorMessageView) ? (self.rightView as! LNErrorMessageView) : nil
    }
    
    func setupErrorMessageView() {
        self.rightView = LNErrorMessageView.errorMessageView()
    }
    
    func setupErrorMessageViewWithImage(_ img : UIImage) {
        self.rightView = LNErrorMessageView.errorMessageView(img)
    }
    
    func setupErrorMessageViewWithView(_ errorMessageView: LNErrorMessageView) {
        self.rightView = errorMessageView
    }
    
    func showError() {
        self.rightViewMode = .always
    }
    
    func hideError() {
        self.rightViewMode = .never
    }
    
    var checkEmoji: Bool{
        if (self.textInputMode?.primaryLanguage == "emoji") || !((self.textInputMode?.primaryLanguage) != nil) {
            return false
        }else{
            return true
        }
    }
    
}


// MARK: - Add Padding to UITextField
extension UITextField {
    
    func addPaddingLeft(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func addPaddingRight(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightView = paddingView
        rightViewMode = .always
    }
    
    func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: padding, height: frame.height)
        leftView = imageView
        leftViewMode = .always
    }
    
    func addPaddingRightIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: padding, height: frame.height)
        rightView = imageView
        rightViewMode = .always
    }
    
}


// MARK: - LNErrorMessageView
class LNErrorMessageView : UIImageView {
    
    class func errorMessageView() -> LNErrorMessageView {
        let errorIconView: LNErrorMessageView = LNErrorMessageView()
        let bundle : Bundle = Bundle(for: LNErrorMessageView.self)
        let url: URL = (bundle.url(forResource: "LetsPod", withExtension: "bundle")! as NSURL) as URL
        let imageBundle: Bundle = Bundle(url: url as URL)!
        var errorIconImage: UIImage = UIImage(contentsOfFile: imageBundle.path(forResource: "errorIcon", ofType: "png")!)!
        errorIconImage = errorIconImage.withRenderingMode(.alwaysTemplate)
        errorIconView.image = errorIconImage
        return errorIconView
    }
    
    class func errorMessageView(_ img : UIImage) -> LNErrorMessageView {
        let errorIconView: LNErrorMessageView = LNErrorMessageView(image:img )
        return errorIconView
    }
    
}

// MARK: - UITextField Style
extension UITextField {
    
    
    func applyStyle(isAspectRatio : Bool = true,leftImage : UIImage? = nil,leftImageContentMode : UIView.ContentMode = .center,rightImage : UIImage? = nil, rightImageContentMode : UIView.ContentMode = .center, x : Int? = 0, y : Int? = 0, w : Int? = 0, h : Int? = 0,placeholder : String? = nil,placeHolderColor : UIColor = .colorTextPlaceHolderGray,textColor : UIColor = .colorTextBlack,fontsize : CGFloat,fontname : CustomFont,mode : UITextField.ViewMode? = .always){
        

        self.font = UIFont.applyCustomFont(fontName: fontname, fontSize: fontsize, isAspectRasio: isAspectRatio)
                
        if placeholder != nil{
            self.placeholder = placeholder
            self.attributedPlaceholder = NSAttributedString(string: placeholder!,attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
        }
        
        self.textColor = textColor
        
        
        if rightImage != nil{
            let imgRightView = UIImageView()
            
            imgRightView.contentMode = rightImageContentMode
            
            if x != 0 || y != 0 || w != 0 || h != 0{
                imgRightView.frame = CGRect(x: x!, y: y!, width: w!, height: h!)
                imgRightView.image = rightImage
                self.addSubview(imgRightView)
                self.rightView = imgRightView
            }else{
                imgRightView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                imgRightView.image = rightImage
                self.addSubview(imgRightView)
                self.rightView = imgRightView
            }
            if mode != nil{
                self.rightViewMode = mode!
            }else{
                self.rightViewMode = .always
            }
            
        }
        
        if leftImage != nil{
            
            let leftImg = UIImageView()
            leftImg.contentMode = leftImageContentMode
            
            
            if x != 0 || y != 0 || w != 0 || h != 0{
                if leftImage == UIImage(){
                    
                    leftImg.frame = CGRect(x: x!, y: y!, width: 5, height: 5)
                }else{
                    leftImg.frame = CGRect(x: x!, y: y!, width: w!, height: h!)
                }
                
                leftImg.image = leftImage
                self.addSubview(leftImg)
                self.leftView = leftImg
            }else{
                leftImg.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                
                leftImg.image = leftImage
                self.addSubview(leftImg)
                self.leftView = leftImg
            }
            if mode != nil{
                self.leftViewMode = mode!
            }else{
                self.leftViewMode = .always
            }
        }
    }
    
}

