//
//  Gui Reis  -  gui.sreis25@gmail.com
//

import UIKit

class MainScreen: UIView {

    // MARK: - Views

    let responseLabel: UILabel = {
        let label = UILabel()
        label.text = "Resposta"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let inputField: UITextField = {
        let field = UITextField()
        field.placeholder = "Digite sua pergunta"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    let keyboardTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Campo com KeyboardHandler"
        field.borderStyle = .roundedRect
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    let askButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Perguntar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Limpar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) { nil }


    // MARK: - Setup

    private func setupHierarchy() {
        addSubview(responseLabel)
        addSubview(inputField)
        addSubview(keyboardTextField)
        addSubview(askButton)
        addSubview(clearButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            responseLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            responseLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            responseLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            inputField.topAnchor.constraint(equalTo: responseLabel.bottomAnchor, constant: 24),
            inputField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            inputField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            askButton.topAnchor.constraint(equalTo: inputField.bottomAnchor, constant: 12),
            askButton.centerXAnchor.constraint(equalTo: centerXAnchor),

            clearButton.topAnchor.constraint(equalTo: askButton.bottomAnchor, constant: 8),
            clearButton.centerXAnchor.constraint(equalTo: centerXAnchor),

            keyboardTextField.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            keyboardTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            keyboardTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
