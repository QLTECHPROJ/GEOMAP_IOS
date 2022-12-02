//
//  UITableView+Extension.swift


import UIKit


extension UITableView {
    
    func scrollToTop() {
        let section = self.numberOfSections
        if section < 0 {
            return
        }
        
        let row = self.numberOfRows(inSection: 0)
        if row < 0 {
            return
        }
        
        self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
    
    func scrollToBottom() {
        let section = self.numberOfSections - 1
        if section < 0 {
            return
        }
        
        let row = self.numberOfRows(inSection: section) - 1
        if row < 0 {
            return
        }
        
        self.scrollToRow(at: IndexPath(row: row, section: section), at: .bottom, animated: false)
    }
    
    // MARK: - Resize HeaderView to Fit It's Content
    func sizeHeaderToFit(tblheaderView: UIView?) {
        if let headerView = tblheaderView{
            
            headerView.setNeedsLayout()
            headerView.layoutIfNeeded()
            
            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var frame = headerView.frame
            frame.size.height = height
            headerView.frame = frame
            
            self.tableHeaderView = headerView
        }
    }
    
    // MARK: - Register TableViewCell with ClassName
    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?
        
        if let bundleName = bundleClass {
            bundle = Bundle(for: bundleName)
        }
        
        register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }
    
    // MARK: - Dequeue TableViewCell with ClassName
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }
    
}
