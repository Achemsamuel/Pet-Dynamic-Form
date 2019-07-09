//
//  PageViewController.swift
//  Pet-Dynamic-Form
//
//  Created by Achem Samuel on 7/7/19.
//  Copyright © 2019 Achem Samuel. All rights reserved.
//

import UIKit
import SnapKit

class PageViewController: UIViewController {

    let label: String
    let section: [Section]
    let sectionLabel : UILabel = UILabel()
    
    var datePicker : UIDatePicker?
    var dateTextField = UITextField()
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var textFieldArray : [UITextField] = [UITextField]()
    var formattedNumTextArray : [UITextField] = [UITextField]()
    var dateFieldArray : [UITextField] = [UITextField]()
    lazy var pagesCount = 0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    
    @objc func viewTapped () {
      view.endEditing(true)
    }
    
     init(label: String, sections : [Section]) {
        
        self.label = label
        self.sectionLabel.text = label
        self.section = sections
        
        super.init(nibName: nil, bundle: nil)
        scrollViewSetup()
        self.stackView.addArrangedSubview(self.sectionLabel)
        
        for i in 0 ..< sections.count {
            getSections(no: i)
            getElements(no: i)
        }
        addSubmitButton(label : label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*-------------------------------
     Mark: Get Sections Methods
     -------------------------------*/
    func getSections (no : Int)  {
        let thisSection = section[no].label
        let sectionsLabel = UILabel()
        sectionsLabel.text = thisSection
        print(sectionsLabel.text!)
        let labelView = views.addLabel(label: thisSection ?? "", view: view)
        self.stackView.addArrangedSubview(labelView)
    }
    
    /*-------------------------------
     Mark: Get Elements Methods
     -------------------------------*/
    lazy var target = [String]()
    lazy var isHiddenState = Bool()
    lazy var hiddenField = UITextField()
    var mySwitch : UISwitch?
    
    func getElements (no : Int) {
        
        for i in (section[no].elements)! {
            
            print("All targets \(target)")
            switch i.type {
            case "embeddedphoto":
                createImageView(imageUrl: i.file ?? "no image url")
            case "text":
                if i.isMandatory == true {
                    let mandatoryTextField = createTextView(placeholder: i.label ?? "", uniqueID: i.unique_id ?? "")
                    mandatoryTextField.requiredField()
                    self.textFieldArray.append(mandatoryTextField)
                    for k in target {
                        if (k == i.unique_id) {
                            self.hiddenField = getTargetElement(textField: mandatoryTextField)
                        }
                    }
                } else {
                    let field = createTextView(placeholder: i.label ?? "", uniqueID: i.unique_id ?? "")
                    for k in target {
                        if (k == i.unique_id) {
                            self.hiddenField = getTargetElement(textField: field)
                        }
                    }

                }
            case "formattednumeric":
                if i.isMandatory == true {
                    let mandatoryPhoneField = createFormattedNumericView()
                    mandatoryPhoneField.requiredField()
                    self.formattedNumTextArray.append(mandatoryPhoneField)
                } else {
                    _ = createFormattedNumericView()
                }
                
            case "datetime":
                if i.isMandatory == true {
                    let mandatoryDateField = createDateView()
                    mandatoryDateField.requiredField()
                    self.dateFieldArray.append(mandatoryDateField)
                } else {
                    _ = createDateView()
                }
                
            case "yesno":
                createLabel(title: i.label ?? "no label for target")
                self.mySwitch = createYesNoSwitch(label: i.label ?? "")
                var action = ""
                var otherwise = ""
                if i.rules?.isEmpty == false {
                    _ = i.rules?.map({ (key) -> String in
                        self.target = key.target ?? ["Nothing here"]
                        action = key.action ?? ""
                        otherwise = key.otherwise ?? ""
                        print(target, action, otherwise)
                        return key.action!
                    })
                }
                
            default:
                print("")
            }
           
        }
        
    }
    
    func isDependent (element : Element) -> Bool {
        
        if element.rules?.isEmpty == false {
            return true
        }
        return false
    }
    
    func getTargetElement (textField : UITextField) -> UITextField {
        textField.isHidden = true
        
        return textField
    }
    
    @objc func switchChanged(sender: UISwitch!) -> Bool {
        
        print("Switch value is \(sender.isOn)")
        if sender.isOn {
            self.hiddenField.isHidden = false
            return true
        } else {
            self.hiddenField.isHidden = true
            return false
        }
    }
    
    /*-------------------------------
     Mark: Get View Methods
     -------------------------------*/
    
    let views = Views()
    func createImageView (imageUrl : String) {
        
        let imageView = views.embedPhoto(fileUrl: imageUrl, view: view, y: 0)
        self.stackView.addArrangedSubview(imageView)
    }
    
    func createTextView (placeholder : String, uniqueID: String) -> UITextField {
        let textView = views.addTextField(label: placeholder, view: view, y: 0, uniqueID: uniqueID)
        self.stackView.addArrangedSubview(textView)
        
        return textView
    }
    
    func createFormattedNumericView () -> UITextField {
        let phoneInputView = views.addFormattedNumberField(label: "phone", view: view, y: 0)
        self.stackView.addArrangedSubview(phoneInputView)
        
        return phoneInputView
    }
    
    func createDateView () -> UITextField {
        let dateTimeView = addDateTimeField(label: "date", view: view, y: 0)
        self.stackView.addArrangedSubview(dateTimeView)
        dateTextField = dateTimeView
        
        return dateTimeView
    }
    
    func createYesNoSwitch (label : String) -> UISwitch {
        
        let yesNo = addSwitch(view: view, label: label)
        self.stackView.addArrangedSubview(yesNo)
        
        return yesNo
    }
    
    func createLabel (title : String) {
        let label = views.addLabel(label: title, view: view)
        self.stackView.addArrangedSubview(label)
    }
    
    func addSubmitButton (label : String) {
        
        self.getPageCount()
        let pageTag = label.filter("0123456789".contains)
        let currentPageNumber = self.stringToInt(value: pageTag)
        if (currentPageNumber == self.pagesCount) {
    
            let submitButton = views.submitButton()
            submitButton.addTarget(self, action: #selector(valaidate), for: .touchUpInside)
            stackView.addArrangedSubview(submitButton)
            
        }
    }
    
    func addSwitch (view : UIView, label : String) -> UISwitch {
        
        let mySwitch = UISwitch()
        mySwitch.center = view.center
        mySwitch.setOn(false, animated: false)
        mySwitch.tintColor = .red
        mySwitch.onTintColor = .flatGreenDark
        mySwitch.thumbTintColor = UIColor.white
        mySwitch.addTarget(self, action: #selector(switchChanged(sender:)), for: UIControl.Event.valueChanged)
        
        return mySwitch
    }
    
    
    
    
    
    /*-------------------------------
     Get Page Count
     -------------------------------*/
    func getPageCount () {
        let parseJson = Parsejson()
        
        parseJson.getPetJsonData { (response) in
            if let pagesN = response.pages?.count {
                self.pagesCount = pagesN
            }
        }
    }
    
    //Convert String to Int
    func stringToInt (value : String) -> Int {
        
        if let newValue : Int = Int(value) {
            return newValue
        } else {
            return 0
        }
    }
    
    
    /*-------------------------------
     Mark: Validation
     -------------------------------*/
    @objc func valaidate() {
        
        let validationKey = validateFields(textArray: textFieldArray, phoneFIeldArray: formattedNumTextArray, dateFieldArray: dateFieldArray)
        if validationKey {
            print("All fields validated")
            successfulAlert()
        } else {
            print("Some required fields are missing")
            missingFieldsAlert()
        }
    }
    
    func validateFields (textArray : [UITextField], phoneFIeldArray : [UITextField], dateFieldArray : [UITextField])  -> Bool {
        
        //TextArray
        for field in textArray {
            if (field.text?.isEmpty == true && field.text!.count < 5) {
                print("You have not filled this correctly")
                
                return false
            }
        }
        
        for field in phoneFIeldArray {
            if (field.text?.isEmpty == true && field.text!.count < 11 && field.text!.count > 11)  {
                print("You did not enter a valid phone number")
                inputCorrectNumber()
                return false
            }
        }
        
        for field in dateFieldArray {
            if (field.text?.isEmpty == true) {
                print("Select the proper date")
                
                return false
            }
        }
        
        return true
        
    }
    
    
}


/*-------------------------------
 Mark: ScrollView Delegate Methods
 -------------------------------*/

extension PageViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

/*-------------------------------
 Mark: ScrollView Setup Methods
 -------------------------------*/
extension PageViewController {
    
    func scrollViewSetup () {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        //Constrain scroll view
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        
        //*********
        self.scrollView.addSubview(self.stackView)
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.axis = .vertical
        self.stackView.spacing = 40
        self.stackView.distribution = .equalSpacing
        self.stackView.backgroundColor = .blue
        //constrain stack view to scroll view
        self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -50).isActive = true
        
        //constrain width of stack view to width of self.view, NOT scroll view
        self.stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        
    }
}

/*-------------------------------
 Mark: Date Setup Methods
 -------------------------------*/

extension PageViewController {
    
    @objc func dateChanged (datePicker: UIDatePicker, textField: UITextField, view : UIView) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        viewTapped()
        
    }
    
    
    func datePickers (textField: UITextField) {
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        textField.inputView = datePicker
        datePicker?.addTarget(self, action: #selector(PageViewController.dateChanged(datePicker:textField:view:)), for: .valueChanged)
        datePicker?.backgroundColor = .white
        
    }
    
    func addDateTimeField (label : String, view : UIView, y: Int) -> UITextField {
        let dateField : UITextField = UITextField(frame: (CGRect(x: 30, y: y, width: Int(view.frame.width - 60), height: 30)))
        //dateField.setPadding(forLeft: 20, forRight: 20)
        dateField.placeholder = label
        dateField.minimumFontSize = 0.3
        dateField.adjustsFontSizeToFitWidth = true
        dateField.borderStyle = .roundedRect
        datePickers(textField: dateField)
        
        
        return dateField
    }
    
    
    

}


/* Alerts */
extension PageViewController {
    
    func missingFieldsAlert () {
        
        let alert = UIAlertController(title: "Missing Fields!", message: "Some required fields are empty or improperly filled. \n Please go back and fill them correctly", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Back", style: .destructive, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func successfulAlert () {
        
        let alert = UIAlertController(title: "Successful", message: "Thank you for submitting an application, we will get back to you shortly", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func inputCorrectNumber () {
        let alert = UIAlertController(title: "Incorrect Number", message: "Please input a correct phone number", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}
