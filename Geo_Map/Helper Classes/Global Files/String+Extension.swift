//
//  String+Extension.swift


import Foundation

extension String {
    func first(char:Int) -> String {
        return String(self.prefix(char))
    }
    
    func last(char:Int) -> String
    {
        return String(self.suffix(char))
    }
    
    func excludingFirst(char:Int) -> String {
        return String(self.suffix(self.count - char))
    }
    
    func excludingLast(char:Int) -> String
    {
        return String(self.prefix(self.count - char))
    }
    
    func getAttributedText ( defaultDic : [NSAttributedString.Key : Any] , attributeDic : [NSAttributedString.Key : Any]?, attributedStrings : [String]) -> NSMutableAttributedString {
        
        let attributeText : NSMutableAttributedString = NSMutableAttributedString(string: self, attributes: defaultDic)
        for strRange in attributedStrings {
            if let range = self.range(of: strRange) {
                let startIndex = self.distance(from: self.startIndex, to: range.lowerBound)
                let range1 = NSMakeRange(startIndex, strRange.count)
                attributeText.setAttributes(attributeDic, range: range1)
            }
        }
        return attributeText
    }
    
    func url() -> URL {
        
        guard let url = URL(string: self) else {
            return URL(string : "www.google.co.in")!
        }
        return url
    }
}

extension String {
    
    var length:Int {
        return self.count
    }
    
    var isValidEmail:Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidName: Bool{
        //let regex =  "^[a-z]([a-z0-9]*[-_][a-z0-9][a-z0-9]*)$"
        let regex = "/^[a-zA-Z ]*$/"
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return usernameTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)
    }
    
    static func isValidMobileNum(txt: String)-> Bool {
        
        let RegEx   = "[0-9]{0,\(Validations.PhoneNo.Maximum.rawValue)}"
        let eTest   = NSPredicate(format:"SELF MATCHES %@", RegEx)
        let result  = eTest.evaluate(with: txt)
        return result;
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var intValue: Int32 {
        return (self as NSString).intValue
    }
    
    var integerValue: Int {
        return (self as NSString).integerValue
    }
    
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    var longLongValue: Int64 {
        return (self as NSString).longLongValue
    }
    
    var boolValue: Bool {
        return (self as NSString).boolValue
    }
    
    var data: Data {
        return self.data(using: String.Encoding.utf8)!
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func getDate(formate:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate //this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
        let date = dateFormatter.date(from: self)
        
        return date!
    }
    
    func dateString(format : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Theme.dateFormats.DOB_App
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = format
        
        if dt != nil {
            return dateFormatter.string(from: dt!)
        }
        
        return ""
    }
    
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
    
    var isBlank :Bool {
        return self.length > 0
    }
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            }
            else {
                return false
            }
        }
        catch {
            return false
        }
    }
    
    func isStringLink() -> Bool {
        let types: NSTextCheckingResult.CheckingType = [.link]
        let detector = try? NSDataDetector(types: types.rawValue)
        guard (detector != nil && self.count > 0) else { return false }
        if detector!.numberOfMatches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) > 0 {
            return true
        }
        return false
    }
    
    func isValidDouble(maxDecimalPlaces: Int) -> Bool {
        // Use NumberFormatter to check if we can turn the string into a number
        // and to get the locale specific decimal separator.
        let formatter = NumberFormatter()
        formatter.allowsFloats = true // Default is true, be explicit anyways
        let decimalSeparator = formatter.decimalSeparator ?? "."  // Gets the locale specific decimal separator. If for some reason there is none we assume "." is used as separator.
        
        // Check if we can create a valid number. (The formatter creates a NSNumber, but
        // every NSNumber is a valid double, so we're good!)
        if formatter.number(from: self) != nil {
            // Split our string at the decimal separator
            let split = self.components(separatedBy: decimalSeparator)
            
            // Depending on whether there was a decimalSeparator we may have one
            // or two parts now. If it is two then the second part is the one after
            // the separator, aka the digits we care about.
            // If there was no separator then the user hasn't entered a decimal
            // number yet and we treat the string as empty, succeeding the check
            let digits = split.count == 2 ? split.last ?? "" : ""
            
            // Finally check if we're <= the allowed digits
            return digits.count <= maxDecimalPlaces    // TODO: Swift 4.0 replace with digits.count, YAY!
        }
        
        return false // couldn't turn string into a valid number
    }
    
    var isBackSpace : Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            return true
        }
        
        return false
    }
    
    var isAlphaWithSpace : Bool {
        let alphaNumericRegex = "[A-Za-z](?:[a-zA-Z]|[ ](?![ ]))*"
        let text = NSPredicate(format:"SELF MATCHES %@", alphaNumericRegex)
        guard text.evaluate(with: self) else { return false }
        return true
    }
    
    var isCharacterWithSpace: Bool{
        let regex = try! NSRegularExpression(pattern: "[a-zA-Z\\s]+", options: [])
        let range = regex.rangeOfFirstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return range.length == self.count
    }
    
    var isCharacterNumberWithSpace: Bool{
        let regex = try! NSRegularExpression(pattern: "[a-zA-Z0-9\\s]+", options: [])
        let range = regex.rangeOfFirstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return range.length == self.count
    }
    
    var isNumberWithSlash : Bool{
        let regex = try! NSRegularExpression(pattern: "[0-9/\\s-]*", options: [])
        let range = regex.rangeOfFirstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return range.length == self.count
    }
    
    var isCountryCode : Bool{
        let regex = try! NSRegularExpression(pattern: "[a-zA-Z0-9+\\s-]*", options: [])
        let range = regex.rangeOfFirstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count))
        return range.length == self.count
    }
    
    var encodeURL:String? {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    
    var isUsernameString : Bool{
        let invalidCharSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz._1234567890").inverted as CharacterSet
        let filtered : String = self.components(separatedBy: invalidCharSet).joined(separator: "")
        return (self == filtered)
    }
    
    var isEmailString : Bool{
        let invalidCharSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz._1234567890@").inverted as CharacterSet
        let filtered : String = self.components(separatedBy: invalidCharSet).joined(separator: "")
        return (self == filtered)
    }
    
    var isCharacter : Bool{
        let invalidCharSet = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz").inverted as CharacterSet
        let filtered : String = self.components(separatedBy: invalidCharSet).joined(separator: "")
        return (self == filtered)
    }
    
    var isNumber : Bool{
        let invalidCharSet = CharacterSet(charactersIn: "1234567890").inverted as CharacterSet
        let filtered : String = self.components(separatedBy: invalidCharSet).joined(separator: "")
        return (self == filtered)
    }
    
    var isNumberWithPoint : Bool{
        let invalidCharSet = CharacterSet(charactersIn: "1234567890.").inverted as CharacterSet
        let filtered : String = self.components(separatedBy: invalidCharSet).joined(separator: "")
        return (self == filtered)
    }
    
    func widhtOfString (_ font : UIFont,height : CGFloat) -> CGFloat {
        let attributes = [NSAttributedString.Key.font:font]
        let rect = NSString(string: self).boundingRect(
            with: CGSize(width: CGFloat.greatestFiniteMagnitude,height: height),
            options: NSStringDrawingOptions.usesLineFragmentOrigin,
            attributes: attributes, context: nil)
        return  rect.size.width
    }
    
    func millisecondToDateString(_ formate : String) -> String {
        return millisecondToDate.toString(formate)!
    }
    
    var millisecondToDate : Date {
        return Date(timeIntervalSince1970: Double(self) != nil ? Double(self)!  / 1000: 0)
    }
    
    func intervalToDateString(_ formate : String) -> String {
        return intervalToDate.toString(formate)!
    }
    
    var intervalToDate : Date {
        return Date(timeIntervalSince1970: Double(self) != nil ? Double(self)! : 0)
    }
    
    func toDate( _ format:String) -> Date? {
        let formatter:DateFormatter = DateFormatter()
        //        formatter.locale = Locale(identifier: "UTC")
        formatter.timeZone =  TimeZone(abbreviation: "UTC")
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    func toLongDate() -> Date? {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .long
        return formatter.date(from: self)
    }
    
    var trim : String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var deshOrText : String {
        return self.trim.isEmpty ? "-" : self
    }
    
    var ns: NSString {
        return self as NSString
    }
    
    var pathExtension: String? {
        return ns.pathExtension
    }
    
    var lastPathComponent: String? {
        return ns.lastPathComponent
    }
    
    func contains(string s: String) -> Bool {
        return self.range(of: s) != nil ? true : false
    }
    
    var htmlToString: String {
        return htmlToAttributedString().string
    }
    
    func htmlToAttributedString() -> NSMutableAttributedString {
        guard let data = data(using: .utf8) else {
            return NSMutableAttributedString(string: self)
        }
        
        do {
            let attributedString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributedString
        } catch {
            return NSMutableAttributedString(string: self)
        }
    }
    
    func htmlAttributed(family: String?, size: CGFloat, color: UIColor) -> NSMutableAttributedString {
        do {
            let htmlCSSString = "<style>" +
            "html *" +
            "{" +
            "font-size: \(size)pt !important;" +
            "color: #\(color.toHex ?? "#313131") !important;" +
            "font-family: \(family ?? "Helvetica"), Helvetica !important;" +
            "}</style> \(self)"
            
            guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                return NSMutableAttributedString(string: self)
            }
            
            return try NSMutableAttributedString(data: data,
                                                 options: [.documentType: NSAttributedString.DocumentType.html,
                                                           .characterEncoding: String.Encoding.utf8.rawValue],
                                                 documentAttributes: nil)
        } catch {
            print("error: ", error)
            return NSMutableAttributedString(string: self)
        }
    }
    
    func attributedString(alignment : NSTextAlignment, lineSpacing : CGFloat) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = lineSpacing // Whatever line spacing you want in points
        
        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        // *** Set Attributed String to your label ***
        return attributedString
    }
    
    func convertIntoJSONString(arrayObject: [Any]) -> String? {
        
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
            if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                return jsonString as String
            }
            
        } catch let error as NSError {
            print("Array convertIntoJSON - \(error.description)")
        }
        return nil
    }
    
    //MARK:- Convert UTC To Local Date by passing date formats value
    func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        // dateFormatter.timeZone = TimeZone(abbreviation: "GMT+08:00") // Australian TimeZone
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = outGoingFormat
        
        return dateFormatter.string(from: dt ?? Date())
    }
    
    //MARK:- Convert Local To UTC Date by passing date formats value
    func localToUTC(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: self)
        // dateFormatter.timeZone = TimeZone(abbreviation: "GMT+08:00") // Australian TimeZone
        dateFormatter.dateFormat = outGoingFormat
        
        return dateFormatter.string(from: dt ?? Date())
    }
    
}
