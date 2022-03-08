import Foundation
func solution() -> Int {
    let N = Int(readLine()!)!
    var dp = [0,0,1,1]
    if N < 4 { return dp[N]}
    for i in 4...N{
        var min = dp[i-1]
        if i%2 == 0 { min = min < dp[i/2] ? min : dp[i/2] }
        if i%3 == 0 { min = min < dp[i/3] ? min : dp[i/3] }
        dp.append(min+1)
    }
    return dp[N]
}

print(solution())
