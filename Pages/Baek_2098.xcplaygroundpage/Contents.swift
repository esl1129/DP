import Foundation

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}



func solution() -> Int {
    let MAX = 10000000
    let CITY = 16
    func TSP(_ visited: Int, _ now: Int) -> Int {
        let nowVisit = visited | (1 << now)
        
        if nowVisit == (1 << N)-1 {
            if brd[now][0] > 0 {
                return brd[now][0]
            }
            return MAX
        }
        
        if dp[nowVisit][now] > 0 {
            return dp[nowVisit][now]
        }
        dp[nowVisit][now] = MAX
        
        for i in 0..<N{
            if i != now && (nowVisit & (1 << i)) == 0 && brd[now][i] > 0 {
                let temp = TSP(nowVisit, i) + brd[now][i]
                if dp[nowVisit][now] > temp {
                    dp[nowVisit][now] = temp
                }
            }
        }
        return dp[nowVisit][now]
    }
    let FIO = FileIO()
    let N = FIO.readInt()
    var brd = [[Int]](repeating: [Int](repeating: 0, count: CITY), count: CITY)
    var dp = [[Int]](repeating: [Int](repeating: 0, count: CITY), count: 1 << CITY)
    for i in 0..<N{
        for j in 0..<N{
            brd[i][j] = FIO.readInt()
        }
    }
    
    return TSP(0, 0)
}

print(solution())
