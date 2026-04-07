//
//  Gui Reis  -  gui.sreis25@gmail.com - 23/04/24
//

import XCTest


final class Uri1028Tests: XCTestCase {
    
    var inputs: [String]! = .init()
    
    
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
        ex1028(input: provider)
        
        // Validation
        XCTAssertEqual(expected, provider.dataPrinted)
    }
    
    
    /* Testes */
    func test_01() {
        // Prepare
        let expected = """
        4
        9
        37
        """
        inputs = ["3", "8 12", "9 27", "259 111"]
        
        // Action
        validate(expected: expected)
    }
}
