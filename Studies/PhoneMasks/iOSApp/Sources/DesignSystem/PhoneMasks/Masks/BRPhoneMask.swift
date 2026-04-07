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


class BRPhoneMask: NSObject {
    var userInput = ""
    lazy var lastFormat = ""
    
    lazy var memoization = [PhoneParts: String]()
    
    func newUserInput(with input: String) -> String {
        var data = userInput
        if input.isEmpty && !userInput.isEmpty {
            data.removeLast()
        } else {
            data = "\(userInput)\(input)"
        }
        return data
    }
    
    func formatPhoneNumber(_ number: String) -> String {
        switch number.count {
        case 0:
            return ""
        case 1:
            return "(\(number)"
        case 2:
            memoization[.area] = number
            return "(\(number))"
        case 3...6:
            let area = memoization[.area].orEmpty
            let prefix = number.dropFirst(2)
            memoization[.prefix] = "\(prefix)"
            return "(\(area)) \(prefix)"
        case 7...10:
            let area = memoization[.area].orEmpty
            let prefix = memoization[.prefix].orEmpty
            let suffix = number.dropFirst(6)
            memoization[.suffix] = "\(suffix)"
            return "(\(area)) \(prefix)-\(suffix)"
        default:
            let area = memoization[.area].orEmpty
            var suffix = memoization[.suffix].orEmpty
            
            let prefix = memoization[.prefix].orEmpty
            let prefix11 = "\(prefix)\(suffix.removeFirst())"
            
            return "(\(area)) \(prefix11)-\(suffix)"
        }
    }
}

// MARK: - + PhoneMaskType
extension BRPhoneMask: PhoneMaskType {
    
    var maxAllowed: Int { 11 }
    var phoneTyped: String { userInput }
        
    func createPhoneMask(newTextTyped: String, rangeChange: NSRange) -> (phone: String, didReachLimit: Bool) {
        let newData = newUserInput(with: newTextTyped)
        guard newData.count <= maxAllowed else { return (lastFormat, true) }
        
        userInput = newData
        lastFormat = formatPhoneNumber(userInput)
        return (lastFormat, false)
    }
}

// MARK: - + UITextFieldDelegate
extension BRPhoneMask: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let data = createPhoneMask(newTextTyped: string, rangeChange: range)
        textField.text = data.phone
        return false
    }
}
