import XCTest

final class PR01Tests: XCTestCase {
    
    var inputs: [String]!
    lazy var ex = ExPR01()
    
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
        let expected = "2"
        inputs = ["4", "100", "200", "150", "300"]
        
        // Action
        validate(expected: expected)
    }
    
    func test_02() {
        // Prepare
        let expected = "0"
        inputs = ["0"]
        
        // Action
        validate(expected: expected)
    }
    
    func test_03() {
        // Prepare
        let expected = "0"
        inputs = []
        
        // Action
        validate(expected: expected)
    }
    
    func test_04() {
        // Prepare
        let expected = "0"
        inputs = ["1", "100"]
        
        // Action
        validate(expected: expected)
    }
}
