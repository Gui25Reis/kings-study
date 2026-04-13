import XCTest

final class HR0010Tests: XCTestCase {

    var inputs: [String]! = .init()
    lazy var ex = Ex0010()

    override func setUp() { super.setUp() }

    override func tearDown() {
        inputs = nil
        super.tearDown()
    }


    /* Aux */
    private func validate(expected: Bool) {
        let provider = MockInputProvider(inputs: inputs)
        let result = ex.solution(input: provider)
        XCTAssertEqual(expected, result)
    }


    /* Testes */
    func test_01() {
        // code_snippet="if (a[0] > b[1]) { doSomething(); }"
        inputs = ["if (a[0] > b[1]) { doSomething(); }"]
        validate(expected: true)
    }

    func test_02() {
        // code_snippet="int x = 42; // no brackets here"
        inputs = ["int x = 42; // no brackets here"]
        validate(expected: true)
    }

    func test_03() {
        // code_snippet="() {} []"
        inputs = ["() {} []"]
        validate(expected: true)
    }

    /* Additional tests */
    func test_04() {
        // code_snippet="" (string vazia)
        inputs = [""]
        validate(expected: true)
    }

    func test_05() {
        // code_snippet="(" (abre sem fechar)
        inputs = ["("]
        validate(expected: false)
    }

    func test_06() {
        // code_snippet=")" (fecha sem abrir)
        inputs = [")"]
        validate(expected: false)
    }

    func test_07() {
        // code_snippet="([)]" (cruzamento de brackets)
        inputs = ["([)]"]
        validate(expected: false)
    }

    func test_08() {
        // code_snippet="{[]}" (aninhamento correto)
        inputs = ["{[]}"]
        validate(expected: true)
    }

    func test_09() {
        // code_snippet="{{{" (multiplos abertos sem fechar)
        inputs = ["{{{"]
        validate(expected: false)
    }

    func test_10() {
        // code_snippet="abc(def[ghi{jkl}mno]pqr)stu" (brackets validos com texto)
        inputs = ["abc(def[ghi{jkl}mno]pqr)stu"]
        validate(expected: true)
    }
    
    func test_11() {
        // code_snippet="abc(def[ghi{jkl}mno]pqr)stu" (brackets validos com texto)
        inputs = ["[ { ( ) } ]"]
        validate(expected: true)
    }
}
