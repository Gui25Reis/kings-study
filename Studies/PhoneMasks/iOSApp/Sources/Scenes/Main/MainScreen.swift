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


class MainScreen: KDSView {
    
    lazy var phoneMask = BRPhoneMask02()
    
    lazy var userInput: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.layer.cornerRadius = 5
        view.delegate = phoneMask
        view.keyboardType = .numberPad
        view.placeholder = "Telefone"
        view.backgroundColor = .systemGray4
        return view
    }()
    
    
    /* Overrides */
    override func setupHierarchy() {
        addSubview(userInput)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            userInput.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            userInput.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            userInput.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            userInput.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
