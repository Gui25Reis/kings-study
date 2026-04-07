//
//  KeyboardHandler.swift
//  QuestionBotApp
//
//  Created by Gui Reis on 15/06/24.
//

import UIKit


fileprivate enum MovimentType {
    case up
    case down
}


class KeyboardHandler: NSObject {
    
    /* Views */
    
    /// TextField que vai ser usado como referênca e gatilho.
    var textField: UITextField
    
    /// View principal que ao tocar vai fazer a remoção do teclado!
    weak var baseView: UIView? {
        willSet { disableKeyboardRemoveTap() }
        didSet { setupKeyboardRemoveTap() }
    }
    
    /// View que vai mover junto com o teclado!
    ///
    /// Por padrão eh o textfield que foi definido
    weak var keyboardView: UIView? {
        willSet { removeKeyboardNotification() }
        didSet { addKeyboardNotification() }
    }
    
    
    /* Outros */
    private var observerKey: Notification.Name {
        UIResponder.keyboardWillShowNotification
    }
    
    private var keyboardRemoveTap: UITapGestureRecognizer!
    
    private(set) var keyboardHeight: CGFloat = 0
    
    /// Último movimento realizado (subida) para sabe o quanto precisa fazer na volta.
    private var lastMovement: CGFloat = 0
    
    // UI
    
    /// Tempo de animação do movimento que a view vai fazer
    var movimentAnimationTime: TimeInterval = 0.25
    
    /// Espaço entre a `keyboardView` e o teclado
    var spaceBetweenKeyboard: CGFloat = 40
    
    
    /* Construtor */
    init(textField: UITextField) {
        self.textField = textField
        super.init()
        createKeyboardRemoveTap()
        setupTextField()
    }
    
    deinit {
        removeKeyboardNotification()
        disableKeyboardRemoveTap()
    }
    
    
    /* Configurações */
    private func setupTextField() {
        textField.delegate = self
        keyboardView = textField
    }
    
    // Tap
    private func createKeyboardRemoveTap() {
        keyboardRemoveTap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    }
    
    private func setupKeyboardRemoveTap() {
        guard let _ = baseView else { return }
        baseView?.addGestureRecognizer(keyboardRemoveTap)
    }
    
    private func disableKeyboardRemoveTap() {
        baseView?.removeGestureRecognizer(keyboardRemoveTap)
    }
    
    
    // Observers
    private func addKeyboardNotification() {
        guard let _ = keyboardView else { return }
        let selector = #selector(keyboardWillShow(_:))
        
        NotificationCenter.default.addObserver(
            self, selector: selector, name: observerKey, object: nil
        )
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(
            self, name: observerKey, object: nil
        )
    }
    
    
    /* Ações */
    
    /// Ação de quando o teclado aparece na tela
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard textField.isEditing else { return }
        
        let key = UIResponder.keyboardFrameEndUserInfoKey
        let frame = notification.userInfo?[key] as? CGRect
        
        keyboardHeight = frame?.height ?? 0
                
        animateViewMoving(to: .up)
    }
    
    /// Remove o teclado da tela
    @objc private func dismissKeyboard() {
        baseView?.endEditing(true)
    }
    
    
    /* Animação */
    
    private func animateViewMoving(to type: MovimentType) {
        UIView.animate(
            withDuration: movimentAnimationTime,
            animations: {
                guard let view = self.keyboardView else { return }
                
                let movement = self.getMovementValue(for: type)
                view.frame = CGRectOffset(view.frame, 0, movement)
            }
        )
    }
    
    private func getMovementValue(for type: MovimentType) -> CGFloat {
        switch type {
        case .up:
            calculatePointsNeededToMove()
            return -lastMovement
        case .down:
            defer { lastMovement = 0 }
            return lastMovement
        }
    }
    
    private func calculatePointsNeededToMove() {
        guard let keyboardView, let window = keyboardView.window else { return }
        
        let winHeight = window.frame.height
        
        let viewHeight = keyboardView.frame.height
        let viewPosY = keyboardView.frame.origin.y
        let viewPosistion = viewPosY + viewHeight
        
        let newPositionExpected = winHeight - keyboardHeight - spaceBetweenKeyboard
        
        let pointToMove = viewPosistion - newPositionExpected
        
        lastMovement = pointToMove
    }
}


// MARK: - + UITextFieldDelegate
extension KeyboardHandler: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(to: .down)
        keyboardHeight = 0
    }
}
