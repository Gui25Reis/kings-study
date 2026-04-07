//
//  Gui Reis  -  gui.sreis25@gmail.com
//

import XCTest

final class LC0001Tests: XCTestCase {
    lazy var ex = Ex0001()

    /* Aux */
    private func validate(nums: [Int], target: Int, expected: [Int]) {
        let result = ex.solution(nums, target)
        XCTAssertEqual(expected, result)
    }


    /* Tests */
    func test_01() {
        validate(nums: [2, 7, 11, 15], target: 9, expected: [0, 1])
    }

    func test_02() {
        validate(nums: [3, 2, 4], target: 6, expected: [1, 2])
    }

    func test_03() {
        validate(nums: [3, 3], target: 6, expected: [0, 1])
    }
}
