/*
 Pivoted Search
 Given a sorted array of unique integers that has been rotated at an unknown pivot, find the index of a target value or return -1 if not found.

 Example

 Input:

 nums = [1609466400, 1609470000, 1609473600, 1609459200, 1609462800]
 target = 1609459200
 Output:

 3
 Explanation:

 We perform a binary search on the rotated array:

 left=0, right=4, mid=(0+4)//2=2, nums[mid]=1609473600.
 nums[left]=1609466400 <= nums[mid], so the left half [indices 0..2] is sorted. Target 1609459200 is not in [1609466400..1609473600], so search in right half: left=mid+1=3.
 Now left=3, right=4, mid=(3+4)//2=3, nums[mid]=1609459200, which equals the target. Return index 3.
 Input Format

 The input is given in three lines.

 Line 1: an integer n (0 ≤ n ≤ 100000), the number of timestamps.

 Line 2: n space-separated long integers nums[i] (0 ≤ nums[i] ≤ 10^18), representing a rotated version of a strictly increasing array of unique Unix timestamps.

 Line 3: a single long integer target (0 ≤ target ≤ 10^18), the timestamp to search for. The sequence in nums is guaranteed to be the result of rotating an originally strictly increasing sorted array at an unknown pivot.

 Constraints

 0 <= nums.length <= 100000
 0 <= nums[i] <= 10^18
 All elements in nums are unique
 nums is obtained by taking a strictly increasing sorted array and rotating it at an unknown pivot
 0 <= target <= 10^18
 Output Format

 Output a single integer: the 0-based index of target in nums if it exists; otherwise output -1.

 Sample Input 0

 0
 5
 Sample Output 0

 -1
 Sample Input 1

 1
 100
 100
 Sample Output 1

 0
 
 
 link: https://www.hackerrank.com/contests/software-engineer-prep-kit/challenges/search-timestamp-in-rotated-log-timestamps
 */

struct ExPR28 {
    func solution(input: InputProvider = DefaultInputProvider()) -> Int {
        guard let nInput = input.readLine(), let n = Int(nInput)
        else { return -1 }

        var nums = [Int]()
        if n > 0 {
            guard let line = input.readLine() else { return -1 }
            nums = line.components(separatedBy: " ").compactMap { Int($0) }
        }

        guard let targetInput = input.readLine(), let target = Int(targetInput)
        else { return -1 }

        return searchRotatedTimestamps(nums: nums, target: target)
    }
}

/*
 Time: O(log n) | Memory: O(1)
 */
fileprivate func searchRotatedTimestamps(nums: [Int], target: Int) -> Int {
    guard !nums.isEmpty else { return -1 }
    
    if nums.count == 1 {
        return nums[0] == target ? 0 : -1
    }
    
    var left = 0
    var right = nums.count-1
    
    while left <= right {
        let mid = (left+right)/2
        
        let midValue = nums[mid]
        
        if midValue == target {
            return mid
        }
        
        let isLeftSideSorted = nums[left] <= midValue
        if isLeftSideSorted {
            if target >= nums[left] && target < midValue {
                right = mid-1
                continue
            }
            left = mid+1
            continue
        }
        
        if target <= nums[right] && target > midValue{
            left = mid+1
            continue
        }
        right = mid-1
    }
    return -1
}
