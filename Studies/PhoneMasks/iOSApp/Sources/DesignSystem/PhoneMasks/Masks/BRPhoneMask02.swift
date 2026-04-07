//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import UIKit


struct PhonePartsModel {
    var area = ""
    var prefix = ""
    var prefix11 = ""
    var suffix = ""
    
    var mask = ""
    var onlyNumber = ""
}

class BRPhoneMask02: NSObject {
    
    lazy var model = PhonePartsModel()
    
    var didChangeCursor = false
    
    private func formatPhoneNumber(userInput: String) {
        var newModel = PhonePartsModel()
        defer { self.model = newModel }
        
        var numberCount = 0
        
        for char in userInput {
            guard char.isNumber && numberCount <= maxAllowed else { continue }
            numberCount += 1
            
            defer { newModel.onlyNumber.append(char) }
            updatePhonePart(char, index: numberCount, model: &newModel)
        }
    }
    
    private func updatePhonePart(_ char: Character, index: Int, model m: inout PhonePartsModel) {
        switch index {
        case 1:
            m.area.append(char)
            m.mask = "(\(m.area)"
        case 2:
            m.area.append(char)
            m.mask = "(\(m.area))"
        case 3...6:
            m.prefix.append(char)
            m.mask = "(\(m.area)) \(m.prefix)"
        case 7:
            m.prefix11 = "\(m.prefix)\(char)"
            m.suffix = "\(char)"
            m.mask = "(\(m.area)) \(m.prefix)-\(m.suffix)"
        case 8...10:
            m.suffix.append(char)
            m.mask = "(\(m.area)) \(m.prefix)-\(m.suffix)"
        case 11:
            m.suffix.append(char)
            m.suffix.removeFirst()
            m.mask = "(\(m.area)) \(m.prefix11)-\(m.suffix)"
        default:
            break
        }
    }
    
    func updateCursorPositionIfNeeded(at textField: UITextField, currentText: String, locationTyped: Int) {
        guard locationTyped < currentText.count else {
            didChangeCursor = false
            return
        }
        
        let offset = didChangeCursor ? locationTyped+1 : locationTyped
        
        let startPosition = textField.position(from: textField.beginningOfDocument, offset: offset)
        guard let startPosition else {
            didChangeCursor = false
            return
        }
        
        textField.selectedTextRange = textField.textRange(from: startPosition, to: startPosition)
        didChangeCursor = true
    }
}

// MARK: - + PhoneMaskType
extension BRPhoneMask02 {
    
    var maxAllowed: Int { 11 }
    var phoneTyped: String { model.onlyNumber }
        
    func createPhoneMask(actualText: String, replacement: String, rangeChanged: NSRange) -> String {
        guard let stringRange = Range(rangeChanged, in: actualText) else { return "" }
        let updatedText = actualText.replacingCharacters(in: stringRange, with: replacement)
        
        if replacement.isEmpty {
            return updatedText
        }
        
        formatPhoneNumber(userInput: updatedText)
        return model.mask
    }
    
    func createPhoneMask(textField: UITextField, replacement str: String, rangeChanged range: NSRange) {
        let currentText = textField.text.orEmpty
        let mask = createPhoneMask(actualText: currentText, replacement: str, rangeChanged: range)
        textField.text = mask
        updateCursorPositionIfNeeded(at: textField, currentText: currentText, locationTyped: range.location)
    }
}

// MARK: - + UITextFieldDelegate
extension BRPhoneMask02: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        createPhoneMask(textField: textField, replacement: string, rangeChanged: range)
        return false
    }
}
