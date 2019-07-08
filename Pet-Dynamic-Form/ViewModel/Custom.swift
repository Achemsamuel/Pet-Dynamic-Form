//
//  SubClasses.swift
//  Pet-Dynamic-Form
//
//  Created by Achem Samuel on 7/6/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import UIKit
import SnapKit

extension UITextField {
   
    func setPadding (forLeft : CGFloat?, forRight : CGFloat?) {
        let LeftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: forLeft ?? 0, height: self.frame.size.height))
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: forRight ?? 0, height: self.frame.size.height))
        
        self.leftView = LeftPaddingView
        self.leftViewMode = .always
        self.rightView = rightPaddingView
        self.rightViewMode = .always
    }
    
    func requiredField () {
        let rightView = UILabel(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.size.height))
        rightView.text = "*"
        rightView.textColor = .red
        self.rightView = rightView
        self.rightViewMode = .always
    }
    
    
}

extension Views {
    func hideShow (textField: UITextField, target : [String], element : Element) {
        
//        for k in target {
//            if (k == element.unique_id) {
//                textField.isHidden = true
//                hiddenFIeld = textField
//                hiddenFIeld.isHidden = true
//                //isHiddenState = true
//
//                let switchState = switchChanged(sender: mySwitch)
//                if !switchState {
//                    textField.isHidden = false
//                } else {
//                    textField.isHidden = true
//                }
//            }
//        }
    }
    
}

