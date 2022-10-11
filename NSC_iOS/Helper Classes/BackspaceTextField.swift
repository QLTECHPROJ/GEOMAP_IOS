//
//  BackSpace.swift
//  YupITNew
//
//  Created by QLTech on 10/02/20.
//  Copyright © 2020 krupa. All rights reserved.
//

import UIKit

class BackspaceTextField: UITextField {
    weak var backspaceTextFieldDelegate: BackspaceTextFieldDelegate?

      override func deleteBackward() {
          if text?.isEmpty ?? false {
              backspaceTextFieldDelegate?.textFieldDidEnterBackspace(self)
          }

          super.deleteBackward()
      }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
protocol BackspaceTextFieldDelegate: class {
    func textFieldDidEnterBackspace(_ textField: BackspaceTextField)
}

protocol MyTextFieldDelegate: AnyObject {
    func textFieldDidDelete()
}

class MyTextField: UITextField {

    weak var myDelegate: MyTextFieldDelegate?

    override func deleteBackward() {
        super.deleteBackward()
        myDelegate?.textFieldDidDelete()
    }

}
