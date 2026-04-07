//
//  Gui Reis  -  gui.sreis25@gmail.com  -  09/04/24.
//

/*
Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

You can return the answer in any order.

link: https://leetcode.com/problems/two-sum/description/
*/

// MARK: - Exercício

struct Ex0001 {
    func solution(_ nums: [Int], _ target: Int) -> [Int] {
        twoSum(nums, target)
    }
}

fileprivate func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    let count = nums.count

    for i in 0..<count {
        for j in 0..<count {
            let result = nums[i] + nums[j]
            if result == target {
                return [i, j]
            }
        }
    }

    return []
}
