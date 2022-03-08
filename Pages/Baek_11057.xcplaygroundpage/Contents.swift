import Foundation
let MOD = 10007
func solution() -> Int {
    let N = Int(readLine()!)!
    var dp = [[],[1,1,1,1,1,1,1,1,1,1]]
    if N < 2 { return dp[N].reduce(0, +) }
    
    for i in 2...N{
        var sam = [dp[i-1][0]]
        for j in 1...9{
            sam.append((sam[j-1]+dp[i-1][j])%MOD)
        }
        dp.append(sam)
    }
    
    return dp[N].reduce(0, +)%MOD
}

print(solution())
