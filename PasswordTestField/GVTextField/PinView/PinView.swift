//
//  PinView.swift
//  PasswordTestField
//
//  Created by Gagan5278 on 15/01/17.
//  Copyright © 2017 Gagan. All rights reserved.
//

import UIKit

class PinView: UIView {
    
    let numberOfPinBlock = numberOfTextFields    //
    var arrayOfPinField = Array<PinField>()
    var isEntryCompleted = false     //use this var if you are making any decision over pin entry status
    
    var nextPinFieldTarget : Int = 0

    override init (frame : CGRect)
    {
        super.init(frame : frame)
        self.createView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Create/Add fields on View
    func createView ()
    {
        let screenRect = UIScreen.main.bounds
        let padding  : CGFloat = 5.0
        
        let remainingWidth = screenRect.size.width - CGFloat((padding*(CGFloat(numberOfPinBlock+1))))
        
        let blockWidth = remainingWidth / CGFloat( numberOfPinBlock)
        
        let xPadding : CGFloat = 0.0
        self.frame = CGRect(x: xPadding, y: self.frame.origin.y, width: screenRect.size.width, height: blockWidth)
        var xPosition = padding
        for i in 0..<numberOfPinBlock
        {
            let pinFieldObject = PinField(frame: CGRect(x: xPosition, y: 0, width: blockWidth, height: blockWidth))
            pinFieldObject.tag = i
            pinFieldObject.delegate = self
            pinFieldObject.delegateDelete = self
            pinFieldObject.addTarget(self, action: #selector (textFieldDidChange(textField:)), for: .editingChanged)
            
            //add object in array of pinfields
            self.arrayOfPinField.append(pinFieldObject)
            self.addSubview(pinFieldObject)
            xPosition = pinFieldObject.frame.origin.x+blockWidth + padding
        }
    }
    
    //MARK:- TextDid change target textfield
    func textFieldDidChange(textField: PinField) {
        self.nextPinFieldTarget = textField.tag + 1
        if (textField.tag < self.arrayOfPinField.count-1)
        {
            let pinField = self.arrayOfPinField[self.nextPinFieldTarget] as PinField
            pinField.becomeFirstResponder()
        }
        else{
            self.isEntryCompleted = true
            textField.resignFirstResponder()
            self.passwordEntryCompled()
        }
    }
    
    //MARK:- Pin Entry Completed
    func passwordEntryCompled(){
        let password = self.getPasswordFromAddedField()
        //...............................Send request from here of perform validation over saved credentials
        print("Enetered Password is : \(password)")
    }
    
    func getPasswordFromAddedField() -> String
    {
        var pinCodeString = String()
        for  pinfield in self.arrayOfPinField
        {
            pinCodeString = pinCodeString + pinfield.text!
        }
        return pinCodeString
    }
}

//MARK:- Delegate for Keyboard backButton press action
extension PinView : KeyboardDeleteDelegate
{
    func deleteButtonPressed()
    {
        if self.nextPinFieldTarget > 0
        {
            self.nextPinFieldTarget -= 1
            let pinField = self.arrayOfPinField[self.nextPinFieldTarget] as PinField
            pinField.becomeFirstResponder()
            pinField.blur()
            pinField.text=""
        }
        else{
            let pinField = self.arrayOfPinField[self.nextPinFieldTarget] as PinField
            pinField.resignFirstResponder()
        }
    }
}

//MARK: - UITextField delegate
extension PinView : UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if self.nextPinFieldTarget < numberOfPinBlock
        {
            let pinBlock = self.arrayOfPinField[self.nextPinFieldTarget] as PinField
            pinBlock.perform(#selector(becomeFirstResponder), with: nil, afterDelay: 0.0)
            pinBlock.focus()
            pinBlock.text = ""
        }
    }
    
    func keyboardInputShouldDelete (pinField : PinField) -> Bool
    {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        let pinField = textField as! PinField
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
