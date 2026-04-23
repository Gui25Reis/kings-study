import XCTest

final class PR51Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = ExPR51()

    override func setUp() { super.setUp() }

    override func tearDown() {
        inputs = nil
        super.tearDown()
    }


    /* Aux */
    private func validate(expected: String) {
        let provider = MockInputProvider(inputs: inputs)
        let result = ex.solution(input: provider)
        XCTAssertEqual(expected, "\(result)")
    }


    /* Testes */
    func test_01() {
        // Grid ja completo (sem zeros)
        let expected = "[[5, 3, 4, 6, 7, 8, 9, 1, 2], [6, 7, 2, 1, 9, 5, 3, 4, 8], [1, 9, 8, 3, 4, 2, 5, 6, 7], [8, 5, 9, 7, 6, 1, 4, 2, 3], [4, 2, 6, 8, 5, 3, 7, 9, 1], [7, 1, 3, 9, 2, 4, 8, 5, 6], [9, 6, 1, 5, 3, 7, 2, 8, 4], [2, 8, 7, 4, 1, 9, 6, 3, 5], [3, 4, 5, 2, 8, 6, 1, 7, 9]]"
        inputs = [
            "9", "9",
            "5 3 4 6 7 8 9 1 2",
            "6 7 2 1 9 5 3 4 8",
            "1 9 8 3 4 2 5 6 7",
            "8 5 9 7 6 1 4 2 3",
            "4 2 6 8 5 3 7 9 1",
            "7 1 3 9 2 4 8 5 6",
            "9 6 1 5 3 7 2 8 4",
            "2 8 7 4 1 9 6 3 5",
            "3 4 5 2 8 6 1 7 9"
        ]
        validate(expected: expected)
    }

    func test_02() {
        // Uma celula vazia: posicao (8,8) = 0, deve ser preenchida com 9
        let expected = "[[5, 3, 4, 6, 7, 8, 9, 1, 2], [6, 7, 2, 1, 9, 5, 3, 4, 8], [1, 9, 8, 3, 4, 2, 5, 6, 7], [8, 5, 9, 7, 6, 1, 4, 2, 3], [4, 2, 6, 8, 5, 3, 7, 9, 1], [7, 1, 3, 9, 2, 4, 8, 5, 6], [9, 6, 1, 5, 3, 7, 2, 8, 4], [2, 8, 7, 4, 1, 9, 6, 3, 5], [3, 4, 5, 2, 8, 6, 1, 7, 9]]"
        inputs = [
            "9", "9",
            "5 3 4 6 7 8 9 1 2",
            "6 7 2 1 9 5 3 4 8",
            "1 9 8 3 4 2 5 6 7",
            "8 5 9 7 6 1 4 2 3",
            "4 2 6 8 5 3 7 9 1",
            "7 1 3 9 2 4 8 5 6",
            "9 6 1 5 3 7 2 8 4",
            "2 8 7 4 1 9 6 3 5",
            "3 4 5 2 8 6 1 7 0"
        ]
        validate(expected: expected)
    }

    /* Additional tests */
    func test_03() {
        // Uma celula vazia: posicao (0,0) = 0, deve ser preenchida com 5
        let expected = "[[5, 3, 4, 6, 7, 8, 9, 1, 2], [6, 7, 2, 1, 9, 5, 3, 4, 8], [1, 9, 8, 3, 4, 2, 5, 6, 7], [8, 5, 9, 7, 6, 1, 4, 2, 3], [4, 2, 6, 8, 5, 3, 7, 9, 1], [7, 1, 3, 9, 2, 4, 8, 5, 6], [9, 6, 1, 5, 3, 7, 2, 8, 4], [2, 8, 7, 4, 1, 9, 6, 3, 5], [3, 4, 5, 2, 8, 6, 1, 7, 9]]"
        inputs = [
            "9", "9",
            "0 3 4 6 7 8 9 1 2",
            "6 7 2 1 9 5 3 4 8",
            "1 9 8 3 4 2 5 6 7",
            "8 5 9 7 6 1 4 2 3",
            "4 2 6 8 5 3 7 9 1",
            "7 1 3 9 2 4 8 5 6",
            "9 6 1 5 3 7 2 8 4",
            "2 8 7 4 1 9 6 3 5",
            "3 4 5 2 8 6 1 7 9"
        ]
        validate(expected: expected)
    }

    func test_04() {
        // Uma celula vazia: posicao (4,4) = 0 (centro, diagonal principal), deve ser preenchida com 5
        let expected = "[[5, 3, 4, 6, 7, 8, 9, 1, 2], [6, 7, 2, 1, 9, 5, 3, 4, 8], [1, 9, 8, 3, 4, 2, 5, 6, 7], [8, 5, 9, 7, 6, 1, 4, 2, 3], [4, 2, 6, 8, 5, 3, 7, 9, 1], [7, 1, 3, 9, 2, 4, 8, 5, 6], [9, 6, 1, 5, 3, 7, 2, 8, 4], [2, 8, 7, 4, 1, 9, 6, 3, 5], [3, 4, 5, 2, 8, 6, 1, 7, 9]]"
        inputs = [
            "9", "9",
            "5 3 4 6 7 8 9 1 2",
            "6 7 2 1 9 5 3 4 8",
            "1 9 8 3 4 2 5 6 7",
            "8 5 9 7 6 1 4 2 3",
            "4 2 6 8 0 3 7 9 1",
            "7 1 3 9 2 4 8 5 6",
            "9 6 1 5 3 7 2 8 4",
            "2 8 7 4 1 9 6 3 5",
            "3 4 5 2 8 6 1 7 9"
        ]
        validate(expected: expected)
    }

    func test_05() {
        // Celula (2,2)=0 resolvivel apenas pelo quadrante (row 2 tem 2 vazios, col 2 tem 2 vazios, quad 0 tem 1 vazio)
        // (0,0) e (2,2) vazios — row 0 tem 1 vazio (resolvel por row), row 2 tem 1 vazio so no quad
        // row 0: vazio em (0,0) -> resolvivel por row (valor=5)
        // quad 0 apos resolver (0,0): 1 vazio em (2,2) -> resolvivel por quad (valor=8... nao, 1+9+3+6+7+2=28, 45-28=17 invalido)
        // Montando caso valido: zerando (1,1)=7 e (2,2)=8, row 1 tem 2 vazios, col 1 tem 2 vazios, quad 0 tem 2 vazios — nao funciona pra 1 vazio no quad
        // Caso: apenas (2,2)=0. Row 2 tem 1 vazio (resolvel por row). Valor esperado = 45-(1+9+3+4+2+5+6+7)=45-37=8
        let expected = "[[5, 3, 4, 6, 7, 8, 9, 1, 2], [6, 7, 2, 1, 9, 5, 3, 4, 8], [1, 9, 8, 3, 4, 2, 5, 6, 7], [8, 5, 9, 7, 6, 1, 4, 2, 3], [4, 2, 6, 8, 5, 3, 7, 9, 1], [7, 1, 3, 9, 2, 4, 8, 5, 6], [9, 6, 1, 5, 3, 7, 2, 8, 4], [2, 8, 7, 4, 1, 9, 6, 3, 5], [3, 4, 5, 2, 8, 6, 1, 7, 9]]"
        inputs = [
            "9", "9",
            "5 3 4 6 7 8 9 1 2",
            "6 7 2 1 9 5 3 4 8",
            "1 9 0 3 4 2 5 6 7",
            "8 5 9 7 6 1 4 2 3",
            "4 2 6 8 5 3 7 9 1",
            "7 1 3 9 2 4 8 5 6",
            "9 6 1 5 3 7 2 8 4",
            "2 8 7 4 1 9 6 3 5",
            "3 4 5 2 8 6 1 7 9"
        ]
        validate(expected: expected)
    }

    func test_06() {
        // Dois vazios em linhas/colunas diferentes, cada um resolvivel pela propria linha
        // (0,0)=0 -> valor 5; (8,8)=0 -> valor 9
        let expected = "[[5, 3, 4, 6, 7, 8, 9, 1, 2], [6, 7, 2, 1, 9, 5, 3, 4, 8], [1, 9, 8, 3, 4, 2, 5, 6, 7], [8, 5, 9, 7, 6, 1, 4, 2, 3], [4, 2, 6, 8, 5, 3, 7, 9, 1], [7, 1, 3, 9, 2, 4, 8, 5, 6], [9, 6, 1, 5, 3, 7, 2, 8, 4], [2, 8, 7, 4, 1, 9, 6, 3, 5], [3, 4, 5, 2, 8, 6, 1, 7, 9]]"
        inputs = [
            "9", "9",
            "0 3 4 6 7 8 9 1 2",
            "6 7 2 1 9 5 3 4 8",
            "1 9 8 3 4 2 5 6 7",
            "8 5 9 7 6 1 4 2 3",
            "4 2 6 8 5 3 7 9 1",
            "7 1 3 9 2 4 8 5 6",
            "9 6 1 5 3 7 2 8 4",
            "2 8 7 4 1 9 6 3 5",
            "3 4 5 2 8 6 1 7 0"
        ]
        validate(expected: expected)
    }
}
