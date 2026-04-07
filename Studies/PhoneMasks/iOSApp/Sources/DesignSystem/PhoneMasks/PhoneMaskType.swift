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


protocol PhoneMaskType: UITextFieldDelegate {
    var maxAllowed: Int { get }
    var phoneTyped: String { get }
    
    func createPhoneMask(newTextTyped: String, rangeChange: NSRange) -> (phone: String, didReachLimit: Bool)
}
