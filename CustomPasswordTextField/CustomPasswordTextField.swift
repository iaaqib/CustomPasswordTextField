//
//  CustomPasswordTextField.swift
//  CustomPasswordTextField
//
//  Created by Aaqib Hussain on 6/8/17.
//  Copyright © 2017 Aaqib Hussain. All rights reserved.
//

import UIKit
@IBDesignable
class CustomPasswordTextField: UITextField, UITextFieldDelegate{
    
    
    //MARK: Variables
    /***
     Toggle Button Font Size default is 12.0
     */
    @IBInspectable var toggleFontSize: CGFloat = 12.0{
        willSet(fontSize){
            let font = self.font ?? UIFont.systemFont(ofSize: fontSize)
            
            toggle.titleLabel!.font = UIFont(descriptor: font.fontDescriptor, size: fontSize)
        }
    }
    
    /***
     TextField Corner Radius default is 5.0
     */
    @IBInspectable var cornerRadius: CGFloat = 5.0{
        
        willSet(radius){
            layer.cornerRadius = radius
        }
    }
    
    /***
     TextField Border Width default is 1.0
     */
    @IBInspectable var borderWidth: CGFloat = 1.0{
        
        willSet(width){
            layer.borderWidth = width
        }
    }
    
    /***
     TextField Border Color when Textfield is in Show State
     */
    
    @IBInspectable var showStateBorderColor: UIColor = UIColor.darkGray{
        
        willSet(showBorder){
            layer.borderColor = showBorder.cgColor
        }
    }
    
    /***
     TextField Border Color when Textfield is in hide State
     */
    @IBInspectable var hideStateBorderColor: UIColor = UIColor.red
    
    /***
     TextField Background Color when Textfield is in Show State
     */
    @IBInspectable var showStateBackgroundColor: UIColor = UIColor.white{
        
        willSet(showBackground){
            backgroundColor = showBackground
        }
    }
    
    /***
     TextField Background Color when Textfield is in Hide State
     */
    @IBInspectable var hideStateBackgroundColor: UIColor = UIColor.red
    
    /***
     TextField Background Color Alpha when Textfield is in hide State default is 0.5
     */
    @IBInspectable var hideStateBackgroundColorAlpha: CGFloat = 0.5
    
    /***
     TextField left view padding
     */
    @IBInspectable var leftPadding: CGFloat = 5.0
    
    /***
     TextField right view padding
     */
    @IBInspectable var rightPadding: CGFloat = 0
    
    /***
     TextField Masking Character to mask with on Hide state on default is '•'
     */
    @IBInspectable var maskingCharacter: String = ""{
        didSet(specialChar){
            maskCharacter = specialChar.characters.first ?? "•"
            changeMaskingString()
        }
        
    }
    
    /***
     Toggle Button title on Show State
     */
    @IBInspectable var onShowToggleText: String = "SHOW"{
        willSet(title){
            toggle.setTitle(title, for: .normal)
        }
        
    }
    
    /***
     Toggle Button title on Hide State
     */
    @IBInspectable var onHideToggleText: String = "HIDE"{
        willSet(title){
            toggle.setTitle(title, for: .selected)
        }
        
    }
    //Contains Original Text without masking
    private var originalText:String = ""{
        didSet {
            changeMaskingString()
        }
    }
    /***
    Returns Original unmasked string
    */
    var originalString: String{
        get{
            return originalText
        }
    }
    
    //Contains Masked Characters
    private var maskedText: String = ""
    
    /*** Returns masked string
     */
    var maskedString: String{
        get{
            return maskedText
        }
    }
    
    //Contains Masking Character
    private var maskCharacter : Character{
        get{
            return self.maskingCharacter.characters.first ?? "•"
        }
        set{}
    }
    //Toggle Variable
    private var toggle: UIButton!
    //Left View
    private var leftViewForPadding: UIView!
   
    
    //MARK: Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        setUp()
    }
    
    //Right View Padding
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }
    //Left View Padding
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    //MARK: Functions
    //SetUp Button and TextField
    func setUp(){
        
        setupShowHideToggle()
        setupTextField()
        
    }
    
    //Setting Up Button
    private func setupShowHideToggle(){
        toggle = UIButton()
        toggle.setTitle(onShowToggleText, for: .normal)
        toggle.setTitle(onHideToggleText, for: .selected)
        toggle.titleLabel!.adjustsFontSizeToFitWidth = true
        toggle.sizeToFit()
        toggle.center = CGPoint(x: 0, y: 0)
        toggle.backgroundColor = .clear
        toggle.setTitleColor(.black, for: .normal)
        toggle.titleLabel!.textAlignment = .left
        toggle.addTarget(self, action: #selector(self.toggleAction), for: .touchUpInside)
        let font = self.font ?? UIFont.systemFont(ofSize: toggleFontSize)
        toggle.titleLabel!.font = UIFont(descriptor: font.fontDescriptor , size: toggleFontSize)
    }
    
    //Setting Up TextField
    private func setupTextField(){
        
        originalText = text ?? ""
        maskCharacter = maskingCharacter.characters.first ?? "•"
        autocorrectionType = .no
        spellCheckingType = .no
        keyboardType = .default
        autocapitalizationType = .none
        isSecureTextEntry = false
        layer.borderColor = showStateBorderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        rightView = toggle
        rightViewMode = .always
        leftViewForPadding = UIView()
        leftView = leftViewForPadding
        leftViewMode = .always
        delegate = self
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
    }
    //Changes Border, Text and Background Color
    private func toggleTextFieldBorderAndBackgroundColorWithText(border: UIColor, background: UIColor, string: String){
        
        layer.borderColor = border.cgColor
        backgroundColor = background
        text = string
        
    }
    //Updates the Masking String
    func changeMaskingString(){
        let maskedString = String(originalText.characters.map{ _ in return self.maskCharacter})
        maskedText = maskedString
        if toggle.isSelected{
            
            text = originalText
        }else{
            text = maskedText
        }
    }
    
    //MARK: Action
    //Toggle Action
    @objc private func toggleAction(_ sender: UIButton){
        
        
        print(sender.isSelected)
        sender.isSelected = !sender.isSelected
        if toggle.isSelected{
            toggleTextFieldBorderAndBackgroundColorWithText(border: hideStateBorderColor, background: hideStateBackgroundColor.withAlphaComponent(hideStateBackgroundColorAlpha), string: originalText)
        }else{
            toggleTextFieldBorderAndBackgroundColorWithText(border: showStateBorderColor, background: showStateBackgroundColor, string: maskedText)
        }
        
        
    }
    //TextField Editing Changed Action
    @objc private func editingChanged(_ sender: UITextField){
        
        changeMaskingString()
    }
    
    
    //MARK: TextField Delegate
    //Holds original text
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        let currentText = self.originalText
        let newString: String = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        self.originalText = newString
        
        
        
        return false
    }
}
