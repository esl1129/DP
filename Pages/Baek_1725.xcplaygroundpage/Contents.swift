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

struct stack{
    var arr: [Int]
    var top: Int
    init() {
        self.arr = []
        self.top = -1
    }
    mutating func push(_ num: Int) {
        self.arr.append(num)
        self.top += 1
    }
    mutating func pop() -> Int {
        let a = self.arr.removeLast()
        self.top -= 1
        return a
    }
    func isEmpty() -> Bool {
        return self.arr.isEmpty ? true : false
    }
}
func solution() -> Int {
    let FIO = FileIO()
    let N = FIO.readInt()
    var h = [Int](repeating: 0, count: 100002)
    var stack = stack()
    var ans = 0
    
    for i in 1...N{
        h[i] = FIO.readInt()
    }
    stack.push(0)
    
    for i in 1...N+1 {
        while !stack.isEmpty() && h[stack.top] > h[i] {
            let idx = stack.top
            _ = stack.pop()
            ans = ans > h[idx]*(i-stack.top-1) ? ans : h[idx]*(i-stack.top-1)
        }
        stack.push(i)
    }
    return ans
}

print(solution())
