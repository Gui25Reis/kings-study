import XCTest

final class PR26Tests: XCTestCase {
    
    var inputs: [String]!
    lazy var ex = ExPR26()
    
    /* Ciclo de Vida */
    override func setUp() {
        super.setUp()
        inputs = []
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
        let expected = "[[1, 6], [8, 10], [15, 18]]"
        inputs = ["4", "2", "1 3", "2 6", "8 10", "15 18"]
        
        // Action
        validate(expected: expected)
    }
    
    func test_02() {
        // Prepare
        let expected = "[[5, 10]]"
        inputs = ["1", "2", "5 10"]
        
        // Action
        validate(expected: expected)
    }
    
    func test_03() {
        // Prepare
        let expected = "[]"
        inputs = ["0", "0"]

        // Action
        validate(expected: expected)
    }


    /* MARK: - Additional tests */
    func test_04() {
        // Prepare
        let expected = "[[1, 5]]"
        inputs = ["2", "2", "3 5", "1 4"]

        // Action
        validate(expected: expected)
    }

    func test_05() {
        // Prepare - intervalo completamente contido dentro de outro
        let expected = "[[1, 10]]"
        inputs = ["2", "2", "1 10", "2 6"]

        // Action
        validate(expected: expected)
    }

    func test_06() {
        // Prepare - intervalos duplicados
        let expected = "[[1, 5]]"
        inputs = ["2", "2", "1 5", "1 5"]

        // Action
        validate(expected: expected)
    }

    func test_07() {
        // Prepare - intervalo contido + overlap na sequência
        let expected = "[[1, 12]]"
        inputs = ["3", "2", "1 10", "3 5", "8 12"]

        // Action
        validate(expected: expected)
    }
}
