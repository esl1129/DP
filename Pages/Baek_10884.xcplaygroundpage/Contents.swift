import Foundation
let MOD = 1000000000
func solution() -> Int {
    let N = Int(readLine()!)!
    var dp = [[],[0,1,1,1,1,1,1,1,1,1]]
    if N < 2 { return dp[N].reduce(0, +) }
    
    for i in 2...N{
        var sam = [Int]()
        for j in 0...9{
            if j == 0 {
                sam.append(dp[i-1][j+1]%MOD)
            } else if j == 9{
                sam.append(dp[i-1][j-1]%MOD)
            } else {
                sam.append((dp[i-1][j-1]+dp[i-1][j+1])%MOD)
            }
        }
        dp.append(sam)
    }
    
    return dp[N].reduce(0, +)%MOD
}

print(solution())
