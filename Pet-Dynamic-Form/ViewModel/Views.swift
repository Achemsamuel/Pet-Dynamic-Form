//
//  Views.swift
//  Pet-Dynamic-Form
//
//  Created by Achem Samuel on 7/5/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import UIKit
import Kingfisher
import LabelSwitch


class Views {

    /*-------------------------------
     Mark: TextField Setup
     -------------------------------*/
    func addTextField (label : String, view : UIView, y: Int, uniqueID : String) -> UITextField {
        let widthPadding : CGFloat = 60
        let textField : UITextField = UITextField(frame: (CGRect(x: 30, y: y, width: Int(view.frame.width - widthPadding), height: 40)))
        //textField.setPadding(forLeft: 20, forRight: 20)
        textField.placeholder = label
        textField.adjustsFontForContentSizeCategory = true
        
        textField.minimumFontSize = 0.3
        textField.adjustsFontSizeToFitWidth = true
        textField.borderStyle = .roundedRect
        textField.adjustsFontSizeToFitWidth = true
        textField.tag = Int(uniqueID.filter("0123456789".contains))!
        textField.minimumFontSize = 10
        textField.font = UIFont(name: textField.font!.fontName, size: 14)
        return textField
    }
    

    /*-----------------------------------
     Mark: Label Setup
     -----------------------------------*/
    func addLabel (label : String, view : UIView) -> UILabel {
        let widthPadding : CGFloat = 60
        let labelView : UILabel = UILabel(frame: (CGRect(x: 30, y: Int(view.frame.minY), width: Int(view.frame.width - widthPadding), height: 40)))
        labelView.adjustsFontSizeToFitWidth = true
        
        
       // labelView.font.familyName = kFontFullNam
       labelView.text = label
        
        return labelView
    }

    /*-----------------------------------
     Mark: Formatted Numeric Setup
     -----------------------------------*/
    func addFormattedNumberField (label : String, view : UIView, y: Int) -> UITextField {

        let textField : UITextField = UITextField(frame: (CGRect(x: 30, y: y, width: Int(view.frame.width - 60), height: 40)))
        textField.placeholder = label
        //textField.setPadding(forLeft: 20, forRight: 20)
        textField.minimumFontSize = 0.3
        textField.adjustsFontSizeToFitWidth = true
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        //setupToolBar(textField: textField)
        return textField
    }
    
    /*-----------------------------------
     Mark: UISwitch Setup
     -----------------------------------*/
/*
    func addSwitch (view : UIView, label : String) -> UISwitch {
        
        let mySwitch = UISwitch()
        mySwitch.center = view.center
        mySwitch.setOn(false, animated: false)
        mySwitch.tintColor = UIColor.blue
        mySwitch.onTintColor = .flatGreenDark
        mySwitch.thumbTintColor = UIColor.white
        mySwitch.addTarget(self, action: #selector(switchChanged(sender:)), for: UIControl.Event.valueChanged)
        
        return mySwitch
    }
    
    @objc func switchChanged(sender: UISwitch!) {
        print("Switch value is \(sender.isOn)")
    }
    */
    func addCustomSwitchField (label : String, view : UIView) -> LabelSwitch {
        let ls = LabelSwitchConfig(text: "Text1",
                                   textColor: .white,
                                   font: UIFont.boldSystemFont(ofSize: 15),
                                   backgroundColor: .red)
        
        let rs = LabelSwitchConfig(text: "Text2",
                                   textColor: .white,
                                   font: UIFont.boldSystemFont(ofSize: 20),
                                   backgroundColor: .green)
        
        // Set the default state of the switch,
        let labelSwitch = LabelSwitch(center: .zero, leftConfig: ls, rightConfig: rs)
        
        // Set the appearance of the circle button
        labelSwitch.circleShadow = false
        labelSwitch.circleColor = .red
        
        // Make switch be triggered by tapping on any position in the switch
        labelSwitch.fullSizeTapEnabled = true
        
        // Set the delegate to inform when the switch was triggered
        labelSwitch.delegate = view as? LabelSwitchDelegate
        
        return labelSwitch
    }

    /*-------------------------------
     Mark: Embed Photo Setup
     -------------------------------*/
    func embedPhoto (fileUrl : String, view : UIView, y: Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        let imageUrl = fileUrl
        //simageView.backgroundColor = .flatRed
        let cornerRadius : CGFloat = 30.0
        imageView.layer.cornerRadius = cornerRadius
        //imageView.layer.borderWidth = 1.0
        //imageView.layer.borderColor = UIColor(red: 0.15, green: 0.06, blue: 0.98, alpha: 1).cgColor
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.shouldRasterize = true
        imageView.clipsToBounds = true
        //Download and set imageView Image
        imageView.kf.setImage(with: URL(string: imageUrl), placeholder: UIImage(named: "Pet Image"), options: [.transition(.fade(0.5)), .cacheOriginalImage, .memoryCacheExpiration(.days(1))])
        
        return imageView
    }
    
    func addView (imageView : UIImageView) -> UIView {
        let container = UIView()
         let cornerRadius : CGFloat = 70.0
        container.frame = CGRect(x: 0, y: 0, width: 160, height: 160)
        container.layer.cornerRadius = cornerRadius
        container.layer.borderColor = UIColor(red: 0.15, green: 0.06, blue: 0.98, alpha: 1).cgColor
        container.layer.borderWidth = 1.0
        container.addSubview(imageView)
        
        return container
    }

    @objc func dismisskey (view: UIView) {
        view.endEditing(true)
    }

    /*-------------------------------
     Mark: Date Setup Methods
     -------------------------------*/

    func setupToolBar (textField : UITextField) {
        
        let pgVC = PageViewController(label: "", sections: [])
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barStyle = .blackTranslucent
        toolbar.barTintColor = .white
        toolbar.tintColor = .green
        toolbar.backgroundColor = .lightGray
        let finishButton = UIBarButtonItem(title: "Finish", style: .done, target: self, action: #selector(pgVC.viewTapped))

        toolbar.setItems([finishButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        
    }

    func hideElementWithTag (tag: String, target: String) {
        
    }
    
    
    func submitButton  () -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .flatGreenDark
        let cornerRadius : CGFloat = 15.0
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(red: 0.93, green: 0.94, blue: 0.95, alpha: 1).cgColor
        button.layer.cornerRadius = cornerRadius
        
        return button
    }

}



extension Views {
   

}

