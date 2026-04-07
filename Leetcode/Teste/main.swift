//
//  main.swift
//  Teste
//
//  Created by Gui Reis on 09/04/24.
//

import Foundation

print("Hello, World!")


class Solution {
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        let count = nums.count

        for i in 0..<count {
            for j in 0..<count {
                let result = nums[i] * nums[j]
                if result == target {
                    return [i, j]
                }
            }
        }

        return []
    }
}


let sol = Solution()


func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
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

print(twoSum([2,7,11,15], 9))
print(twoSum([3,2,4], 6))
