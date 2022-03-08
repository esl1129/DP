import Foundation
let MOD = 10007
func solution() -> Int {
    let N = Int(readLine()!)!
    var dp = [0,1,3]
    if N < 3 { return dp[N]}
    for i in 3…N{
        dp.append((dp[i-2]*2+dp[i-1])%MOD)
    }
    return dp[N]%MOD
}

print(solution())
