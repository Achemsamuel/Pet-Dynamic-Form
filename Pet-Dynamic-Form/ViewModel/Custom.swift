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

extension UISwitch {
    
    func addRView () {
        
        
    }
}

extension Views {
 
    
}

