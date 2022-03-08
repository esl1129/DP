import Foundation
func solution() -> Int {
    let N = Int(readLine()!)!
    var dp = [0,1,1]
    if N < 3 { return dp[N]}
    for i in 3...N{
        dp.append(dp[i-1]+dp[i-2])
    }
    return dp[N]
}

print(solution())
