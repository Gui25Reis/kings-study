//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

protocol ViewCode {
    func setupView()
    func setupHierarchy()
    func setupConstraints()
    func additionalSetup()
}

// MARK: - Default implementations
extension ViewCode {
    
    func setupView() {
        setupHierarchy()
        setupConstraints()
        additionalSetup()
    }
    
    func additionalSetup() {
        /* Mantendo opcional */
    }
}
