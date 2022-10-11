//
//  DJPickerView.swift
//


import UIKit

public enum DJPickerViewType {
    case date, strings
}

public protocol DJPickerViewDelegate: class {
    // date picker delegate
    func textPickerView(_ textPickerView: DJPickerView, didSelectDate date: Date)
    
    // strings picker delegate
    func textPickerView(_ textPickerView: DJPickerView, didSelectString row: Int)
    func textPickerView(_ textPickerView: DJPickerView, titleForRow row: Int) -> String?
}

public extension DJPickerViewDelegate {
    // date picker delegate
    func textPickerView(_ textPickerView: DJPickerView, didSelectDate date: Date) {}
    
    // strings picker delegate
    func textPickerView(_ textPickerView: DJPickerView, didSelectString row: Int) {}
    func textPickerView(_ textPickerView: DJPickerView, titleForRow row: Int) -> String? { return nil }
}

public protocol DJPickerViewDataSource: class {
    func numberOfRows(in pickerView: DJPickerView) -> Int
}

public class DJPickerView: DJTextField {
    
    //    @IBInspectable var leftPadding: CGFloat = 0
    
    //    override public func textRect(forBounds bounds: CGRect) -> CGRect {
    //        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 0))
    //    }
    
    //    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    //        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 0))
    //    }
    //
    //    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
    //        return bounds.inset(by: UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: 0))
    //    }
    
    override public func awakeFromNib()
    {
        super.awakeFromNib()
        //        self.placeholder = Localization(string: localizationKey)
    }
    
    // MARK: public properties
    public var type: DJPickerViewType = .strings {
        didSet {
            _updateType()
        }
    }
    
    // date picker properties
    public var currentDate = Date()
    private(set) public var datePicker: UIDatePicker?
    public var dateFormatter = DateFormatter()
    
    // strings picker properties
    public var currentIndexSelected: Int? {
        didSet {
            _selectRowString()
        }
    }
    private(set) public var dataPicker: UIPickerView?
    public weak var dataSource: DJPickerViewDataSource?
    
    // common properties
    private(set) public var toolbar: UIToolbar?
    public weak var pickerDelegate: DJPickerViewDelegate?
    public var cancelText = "Cancel" {
        didSet {
            _updateToolbar()
        }
    }
    public var doneText = "Done" {
        didSet {
            _updateToolbar()
        }
    }
    public var pickerTitle: String? {
        didSet {
            _updateToolbar()
        }
    }
    
    // MARK: init methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        _initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _initialize()
    }
    
    private func _initialize() {
        _updateType()
        _updateToolbar()
    }
    
    override open func caretRect(for position: UITextPosition) -> CGRect {
        return .zero
    }
    
    // MARK: private
    
    private func _updateType() {
        switch type {
        case .strings: _initDataPicker()
        case .date: _initDatePicker()
        }
    }
    
    // date picker setup
    private func _initDatePicker() {
        dataPicker = nil
        datePicker = UIDatePicker()
        if #available(iOS 13.4, *) {
            datePicker?.preferredDatePickerStyle = .wheels
        }
        datePicker?.backgroundColor = .white
        //datePicker?.locale = Locale(identifier: "en_US")
        //        datePicker?.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker?.datePickerMode = .date
        inputView = datePicker
    }
    
    private func _selectDate() {
        currentDate = datePicker?.date ?? currentDate
        text = dateFormatter.string(from: currentDate)
        pickerDelegate?.textPickerView(self, didSelectDate: currentDate)
    }
    
    // strings data picker setup
    private func _initDataPicker() {
        datePicker = nil
        dataPicker = UIPickerView()
        dataPicker?.backgroundColor = UIColor.white
        dataPicker?.delegate = self
        dataPicker?.dataSource = self
        inputView = dataPicker
    }
    
    private func _selectString() {
        if let row = dataPicker?.selectedRow(inComponent: 0) {
            text = pickerDelegate?.textPickerView(self, titleForRow: row)
            pickerDelegate?.textPickerView(self, didSelectString: row)
        }
    }
    
    private func _selectRowString() {
        guard let row = currentIndexSelected, let count = dataSource?.numberOfRows(in: self), row < count else { return }
        dataPicker?.selectRow(row, inComponent: 0, animated: true)
    }
    
    // toolbar setup
    private func _updateToolbar() {
        
        let cancelButton = UIBarButtonItem(title: cancelText, style: .plain, target: self, action: #selector(_cancel)),
        space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
        doneButton = UIBarButtonItem(title: doneText, style: .done, target: self, action: #selector(_done)),
        titleBarButton = UIBarButtonItem(title: pickerTitle ?? placeholder, style: .done, target: nil, action: nil)
        titleBarButton.isEnabled = false
        
        toolbar = UIToolbar()
        toolbar?.barStyle = .default
        toolbar?.isTranslucent = false
        toolbar?.setItems([cancelButton, space, titleBarButton, space, doneButton], animated: false)
        toolbar?.isUserInteractionEnabled = true
        toolbar?.sizeToFit()
        
        inputAccessoryView = toolbar
    }
    
    // MARK: action methods
    
    @objc private func _cancel() {
        datePicker?.date = currentDate
        endEditing(true)
    }
    
    @objc private func _done() {
        switch type {
        case .strings: _selectString()
        case .date: _selectDate()
        }
        endEditing(true)
    }
    //    @IBInspectable var localizationKey : String = ""
    //
    //    @objc func changeTitle()  {
    //        self.placeholder = Localization(string: localizationKey)
    //    }
}

extension DJPickerView: UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource?.numberOfRows(in: self) ?? 0
    }
}

extension DJPickerView: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let string = pickerDelegate?.textPickerView(self, titleForRow: row)
        return NSAttributedString(string: string!, attributes: [NSAttributedString.Key.foregroundColor:UIColor.black])
    }
    
    //    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    //        return pickerDelegate?.textPickerView(self, titleForRow: row)
    //    }
}
