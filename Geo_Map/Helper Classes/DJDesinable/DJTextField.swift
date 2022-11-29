//
//  DJTextField.swift
//

import UIKit

//@IBDesignable
public class DJTextField : UITextField {
    
    var topBorder: UIView?
    var bottomBorder: UIView?
    var leftBorder: UIView?
    var rightBorder: UIView?
    var leftimageview : UIImageView?
    var rightimageview : UIImageView?
    
    private var __maxLengths = [UITextField: Int]()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    override public func awakeFromNib()
    {
        super.awakeFromNib()
        //        self.placeholder = Localization(string: localizationKey)
    }
    
    override public func deleteBackward() {
        super.deleteBackward()
        NotificationCenter.default.post(name: NSNotification.Name("deletePressed"), object: self)
        
    }
    @IBInspectable var rightImage : UIImage?
        {
        didSet
        {
            if rightImage != nil
            {
                let width = rightviewWidth > rightImage!.size.width + 10 ? rightviewWidth :  rightImage!.size.width + 10
                rightViewMode = UITextField.ViewMode.always
                rightimageview = UIImageView()
                rightimageview!.frame=CGRect(x: self.frame.size.width - width,y: self.frame.origin.y+2,width: width,height: self.frame.size.height-4)
                rightimageview!.image = rightImage
                rightView = rightimageview
                self.rightViewMode = .always
                rightimageview!.contentMode = .center
            }
        }
    }
    @IBInspectable var rightviewWidth : CGFloat = 0
        {
        didSet
        {
            if rightimageview != nil
            {
                let width = rightviewWidth > rightImage!.size.width + 10 ? rightviewWidth :  rightImage!.size.width + 10
                rightimageview!.frame=CGRect(x: self.frame.origin.x+5,y: self.frame.origin.y+2,width: width, height: self.frame.size.height-4)
            }
        }
    }
    
//    @IBInspectable var borderColor: UIColor = UIColor.clear
//        {
//        didSet
//        {
//            layer.borderColor = borderColor.cgColor
//        }
//    }
//
//    @IBInspectable var borderWidth: CGFloat = 0
//        {
//        didSet
//        {
//            layer.borderWidth = borderWidth
//        }
//    }
    
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 40 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
    
//    @IBInspectable var cornerRadius: CGFloat = 0
//        {
//        didSet
//        {
//            layer.cornerRadius = cornerRadius
//        }
//    }
    
    @IBInspectable var leftImage : UIImage?
        {
        didSet
        {
            if leftImage != nil
            {
                let width = leftviewWidth > leftImage!.size.width + 10 ? leftviewWidth :  leftImage!.size.width + 10
                leftViewMode = UITextField.ViewMode.always
                leftimageview = UIImageView();
                leftimageview!.frame = CGRect(x: self.frame.origin.x+10,y: self.frame.origin.y+2,width: width,height: self.frame.size.height-4)
                leftimageview!.image = leftImage;
                leftView = leftimageview;
                self.leftViewMode = .always
                leftimageview!.contentMode = .center
            }
        }
    }
    @IBInspectable var leftviewWidth : CGFloat = 0
        {
        didSet
        {
            if leftimageview != nil
            {
                let width = leftviewWidth > leftImage!.size.width + 10 ? leftviewWidth :  leftImage!.size.width + 10
                leftimageview!.frame = CGRect(x: self.frame.origin.x+10,y: self.frame.origin.y+2,width: width,height: self.frame.size.height-4)
            }
        }
    }
    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    override public func textRect(forBounds bounds: CGRect) -> CGRect
    {
        super.textRect(forBounds: bounds)
        return CGRect(x: bounds.origin.x + paddingLeft,y: bounds.origin.y,
                      width: bounds.size.width - paddingLeft - paddingRight,height: bounds.size.height);
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect
    {
        super.editingRect(forBounds: bounds)
        return textRect(forBounds: bounds)
    }
    @IBInspectable var topBorderColor : UIColor = UIColor.clear
    @IBInspectable var topBorderHeight : CGFloat = 0
        {
        didSet
        {
            if topBorder == nil{
                topBorder = UIView()
                addSubview(topBorder!)
            }
            topBorder?.backgroundColor = topBorderColor
            topBorder?.frame = CGRect(x: 0,y: 0,width: self.frame.size.width,height: topBorderHeight)
        }
    }
    @IBInspectable var bottomBorderColor : UIColor = UIColor.clear
        {
        didSet
        {
            bottomBorder?.backgroundColor = bottomBorderColor
        }
    }
    @IBInspectable var bottomBorderHeight : CGFloat = 0
        {
        didSet
        {
            if bottomBorder == nil
            {
                bottomBorder = UIView()
                addSubview(bottomBorder!)
            }
            bottomBorder?.backgroundColor = bottomBorderColor
            bottomBorder?.frame = CGRect(x: 0,y: self.frame.size.height - bottomBorderHeight,width: self.frame.size.width,height: bottomBorderHeight)
        }
    }
    @IBInspectable var leftBorderColor : UIColor = UIColor.clear
    @IBInspectable var leftBorderHeight : CGFloat = 0
        {
        didSet
        {
            if leftBorder == nil
            {
                leftBorder = UIView()
                addSubview(leftBorder!)
            }
            leftBorder?.backgroundColor = leftBorderColor
            leftBorder?.frame = CGRect(x: 0,y: 0,width: leftBorderHeight,height: self.frame.size.height)
        }
    }
    @IBInspectable var rightBorderColor : UIColor = UIColor.clear
    @IBInspectable var rightBorderHeight : CGFloat = 0
        {
        didSet
        {
            if rightBorder == nil
            {
                rightBorder = UIView()
                addSubview(rightBorder!)
            }
            rightBorder?.backgroundColor = rightBorderColor
            rightBorder?.frame = CGRect(x: self.frame.size.width - rightBorderHeight,y: 0,width: rightBorderHeight,height: self.frame.size.height)
        }
    }
    
    override public func layoutSubviews()
    {
        super.layoutSubviews()
        bottomBorder?.frame = CGRect(x: 0,y: self.frame.size.height - bottomBorderHeight,width: self.frame.size.width,height: bottomBorderHeight)
        rightBorder?.frame = CGRect(x: self.frame.size.width - rightBorderHeight,y: 0,width: rightBorderHeight,height: self.frame.size.height)
    }
    @IBInspectable var localizationKey : String = ""
    
    
    @objc func changeTitle()  {
        //        self.placeholder = Localization(string: localizationKey)
    }
}

