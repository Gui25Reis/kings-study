import XCTest

final class HR0006Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = Ex0006()

    /* Ciclo de Vida */
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        inputs = nil
        super.tearDown()
    }


    /* Aux */
    private func validate(expected: String) {
        // Prepare
        let provider = MockInputProvider(inputs: inputs)

        // Action
        let result = ex.solution(input: provider)

        // Validation
        XCTAssertEqual(expected, "\(result)")
    }


    /* Testes */
    func test_01() {
        // Prepare
        // nums=[1,2,3,4,5], target=3
        let expected = "2"
        inputs = ["5", "3", "1 2 3 4 5"]

        // Action
        validate(expected: expected)
    }

    func test_02() {
        // Prepare - sample 0: array vazio
        // nums=[], target=5
        let expected = "-1"
        inputs = ["0", "5"]

        // Action
        validate(expected: expected)
    }

    func test_03() {
        // Prepare - sample 1: unico elemento encontrado
        // nums=[3], target=3
        let expected = "0"
        inputs = ["1", "3", "3"]

        // Action
        validate(expected: expected)
    }

    /* Additional tests */
    func test_04() {
        // Prepare - duplicatas, retorna o primeiro indice
        // nums=[1,2,3,3,3,4], target=3
        let expected = "2"
        inputs = ["6", "3", "1 2 3 3 3 4"]

        // Action
        validate(expected: expected)
    }

    func test_05() {
        // Prepare - target nao existe
        // nums=[1,2,4,5], target=3
        let expected = "-1"
        inputs = ["4", "3", "1 2 4 5"]

        // Action
        validate(expected: expected)
    }

    func test_06() {
        // Prepare - target eh o primeiro elemento
        // nums=[3,3,4,5], target=3
        let expected = "0"
        inputs = ["4", "3", "3 3 4 5"]

        // Action
        validate(expected: expected)
    }

    func test_07() {
        // Prepare - target eh o ultimo elemento
        // nums=[1,2,3,5,5], target=5
        let expected = "3"
        inputs = ["5", "5", "1 2 3 5 5"]

        // Action
        validate(expected: expected)
    }

    func test_08() {
        // Prepare - todos os elementos sao iguais ao target
        // nums=[2,2,2,2], target=2
        let expected = "0"
        inputs = ["4", "2", "2 2 2 2"]

        // Action
        validate(expected: expected)
    }

    func test_09() {
        // Prepare - negativos no array
        // nums=[-5,-3,-3,-1,2], target=-3
        let expected = "1"
        inputs = ["5", "-3", "-5 -3 -3 -1 2"]

        // Action
        validate(expected: expected)
    }
    
    func test_10() {
        // Prepare - apenas um número
        // nums=[1,1,1,1,1], target=1
        let expected = "0"
        inputs = ["5", "1", "1 1 1 1 1"]

        // Action
        validate(expected: expected)
    }
}
