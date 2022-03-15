import Foundation

func solution() -> Int {
    let N = Int(readLine()!)!
    let L = Int(readLine()!)!
    let CD = Int(readLine()!)!
    
    var max = (CD-L)/(L+1)+1
    max = N < max ? N : max
    max = max%13 == 0 ? max-1 : max
    if N%max == 0 {
        return N/max
    } else {
        if (N%max)%13 == 0 && N%max == max-1 {
            return N/max+2
        } else {
            return N/max+1
        }
    }
}

print(solution())
