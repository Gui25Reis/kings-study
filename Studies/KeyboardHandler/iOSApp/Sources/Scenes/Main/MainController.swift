//
//  Gui Reis  -  gui.sreis25@gmail.com
//

import UIKit

class MainController: UIViewController {

    // MARK: - Views

    private let screen = MainScreen()


    // MARK: - Atributos

    private let handler = BotHandler()

    private var keyboardHandler: KeyboardHandler?


    // MARK: - Ciclo de Vida

    override func loadView() {
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardHandler()
        screen.askButton.addTarget(self, action: #selector(handleQuestionAction), for: .touchUpInside)
        screen.clearButton.addTarget(self, action: #selector(clearAction), for: .touchUpInside)
    }


    // MARK: - Ações

    @objc private func handleQuestionAction() {
        let answer = handler.resolve(question: screen.inputField.text)
        screen.responseLabel.text = answer
    }

    @objc private func clearAction() {
        screen.responseLabel.text = "Resposta"
        screen.inputField.text = nil
    }


    // MARK: - Configurações

    private func setupKeyboardHandler() {
        keyboardHandler = KeyboardHandler(textField: screen.keyboardTextField)
        keyboardHandler?.baseView = view
    }
}
