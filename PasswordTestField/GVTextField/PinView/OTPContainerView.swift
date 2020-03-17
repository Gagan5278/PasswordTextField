//
//  OTPContainerView.swift
//  bank42
//
//  Created by Gagan Vishal on 2020/03/10.
//  Copyright © 2020 Meniga. All rights reserved.
//

import Foundation
import UIKit
protocol RegisterSecondaryDevice {
    func registerSecondaryDevice(with token: String)
}

@IBDesignable class PinContainerStackView: UIStackView {
    var registerDelegate: RegisterSecondaryDevice?
   /// Number of fields
   @IBInspectable var fields: Int = 0 {
        didSet {
            // Update number of arranged views
            insertSubviews(fields)
        }
    }
    
    var arrayOfPinField = Array<OTPTextfield>()
    var isEntryCompleted = false     //use this var if you are making any decision over pin entry status
    var nextPinFieldTarget : Int = 0
    
    /// Current active field
    private lazy var active: OTPTextfield = {
        return self.arrayOfPinField[self.nextPinFieldTarget] as OTPTextfield 
    }()
    
    /**
     Inserts n number of subviews to the stackview
     - parameter n: The number of subviews to be inserted
     */
    private func insertSubviews(_ n: Int) {
        axis = .horizontal
        distribution = .fillEqually
        alignment = .center
        spacing = 15.0
        for i in 0..<n {
            let pinFieldObject = OTPTextfield(frame: .zero)
            pinFieldObject.backgroundColor = .white
            addArrangedSubview(pinFieldObject)
            pinFieldObject.translatesAutoresizingMaskIntoConstraints = false
            pinFieldObject.tag = i
            pinFieldObject.delegate = self
            pinFieldObject.delegateDelete = self
            pinFieldObject.addTarget(self, action: #selector (textFieldDidChange(textField:)), for: .editingChanged)
            
            pinFieldObject.addToolbarWithNextButton(onDone: (target: self, action: #selector(doneButtonAction)))
            //
            self.arrayOfPinField.append(pinFieldObject)
        }
        
        // Set the color of the active view
        active.borderColor = .blue
    }
    
    //MARK:- TextDid change target textfield
    @objc func textFieldDidChange(textField: OTPTextfield) {
        self.nextPinFieldTarget = textField.tag + 1
        if (textField.tag < self.arrayOfPinField.count-1)
        {
            let pinField = self.arrayOfPinField[self.nextPinFieldTarget] as OTPTextfield
            pinField.becomeFirstResponder()
        }
        else{
            self.isEntryCompleted = true
            textField.resignFirstResponder()
            self.passwordEntryCompleted()
        }
    }
    
    //MARK:- Pin Entry Completed
    func passwordEntryCompleted(){
        //...............................Send request from here of perform validation over saved credentials
        self.registerDelegate?.registerSecondaryDevice(with: self.getPasswordFromAddedField())
    }
    
    //MARK:- Get entered OTP
    fileprivate func getPasswordFromAddedField() -> String
    {
        var pinCodeString = String()
        for  pinfield in self.arrayOfPinField
        {
            pinCodeString = pinCodeString + pinfield.text!
        }
        return pinCodeString
    }
    
    //MARK:- Done button action
    @objc private func doneButtonAction() {
        self.endEditing(true)
       // self.active.resignFirstResponder()
    }
}

//MARK:- Delegate for Keyboard backButton press action
extension PinContainerStackView : KeyboardDeleteDelegate
{
    func deleteButtonPressed()
    {
        if self.nextPinFieldTarget > 0
        {
            self.nextPinFieldTarget -= 1
            let pinField = self.arrayOfPinField[self.nextPinFieldTarget] as OTPTextfield
            pinField.becomeFirstResponder()
            pinField.text=""
        }
        else{
            let pinField = self.arrayOfPinField[self.nextPinFieldTarget] as OTPTextfield
            pinField.resignFirstResponder()
        }
    }
}


//MARK: - UITextField delegate
extension PinContainerStackView : UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.nextPinFieldTarget < self.fields
        {
            let pinBlock = self.arrayOfPinField[self.nextPinFieldTarget] as OTPTextfield
            pinBlock.perform(#selector(becomeFirstResponder), with: nil, afterDelay: 0.0)
            pinBlock.focus()
            pinBlock.text = ""
        }
    }
    
    func keyboardInputShouldDelete (pinField : OTPTextfield) -> Bool
    {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        let pinField = textField as! OTPTextfield
        if pinField.text == "" ||  pinField.text == "*"
        {
            pinField.text = ""
            pinField.blur()
        }
        else
        {
            pinField.blur()
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      //Capture added text here
        return true
    }
}
