//
//  DJCheckBox.swift
//

import UIKit

//@IBDesignable
class DJCheckBox: UIControl {
    
    fileprivate var imageView = UIImageView()
    fileprivate var labelView = UILabel()
    
    var selectedCollectionCell = 0
    var selectedItems = 0
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    required public init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    
    @IBInspectable var checkImage : UIImage?
    {
        didSet
        {
            if checkImage != nil && isChecked
            {
                imageView.image = checkImage
            }
        }
    }
    @IBInspectable var unCheckImage : UIImage?
        {
        didSet
        {
            if unCheckImage != nil && !isChecked
            {
                imageView.image = unCheckImage
            }
        }
    }
    @IBInspectable var isChecked : Bool = true
    {
        didSet
        {
            if isChecked {
                imageView.image = checkImage
                font = UIFont(name: Theme.fonts.semiBold, size: 15)!
            }
            else {
                font = UIFont(name: Theme.fonts.medium, size: 15)!
                imageView.image = unCheckImage
            }
        }
    }
    @IBInspectable var font : UIFont = UIFont(name: Theme.fonts.medium, size: 15)!
        {
        didSet
        {
            labelView.font = font
        }
    }
    @IBInspectable var text : String = "Label"
        {
        didSet
        {
            labelView.text = text
        }
    }
    @IBInspectable var isCenter: Bool = false

    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var textColor: UIColor = UIColor.black
    
    override func layoutSubviews() {
        imageView.frame = CGRect(x: isCenter ? (self.center.x - (self.frame.size.height / 2.0)) : 0, y: 0, width: self.frame.size.height, height: self.frame.size.height)
        imageView.contentMode = contentMode
        
        labelView.frame = CGRect(x: imageView.frame.origin.x + imageView.frame.size.width + paddingLeft, y: 0, width: self.frame.width - (imageView.frame.size.width + paddingLeft) , height: self.frame.height)
        labelView.textColor = textColor
        if isChecked {
            labelView.font = UIFont(name: Theme.fonts.semiBold, size: 15)
        }
        else {
            labelView.font = UIFont(name: Theme.fonts.medium, size: 15)
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        if isChecked {
            isChecked = false
        }
        else {
            isChecked = true
        }
        self.sendActions(for: .valueChanged)
        return true
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height)
        addSubview(imageView)
        labelView.frame = CGRect(x: imageView.frame.origin.x + imageView.frame.size.width + paddingLeft, y: 0, width: self.frame.width - (imageView.frame.size.width + paddingLeft) , height: self.frame.height)
        labelView.text = text
        addSubview(labelView)
        
    }
}

