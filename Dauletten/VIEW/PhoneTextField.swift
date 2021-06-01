//
//  PhoneTextField.swift
//  VideoLessons
//
//  Created by Eldor Makkambayev on 2/12/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit
class PhoneTextField: UITextField {
    
    //MARK:- Preasure
    
    fileprivate var label: UILabel = {
        let label = UILabel()
        label.text = ""
        
        return label
    }()
    
    //MARK:- Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9803921569, blue: 0.9882352941, alpha: 1)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- SetupViews
    func setupViews() -> Void {
        
        leftView = label
        leftViewMode = .always
        rightViewMode = .always
        delegate = self
        keyboardType = .decimalPad
    }
    
}
//MARK:- UITextFieldDelegate
extension PhoneTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text!
        let spaceIndex = [2, 6, 10, 13]

        if text == "+7" && string == "" {
            return false
        }

        if text.count == 16 && string != "" {
            return false
        }

        if spaceIndex.contains(textField.text!.count) && string != "" {
            textField.text!.append(" ")
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "+7" || textField.text == "+7 " || textField.text == "+"{
            textField.text = ""
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            textField.text = "+7"
        }
    }

    
}
