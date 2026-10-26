struct lib {
    static func first(data: [String]) -> Int {
        var outs: [String: [String]] = Dictionary()
        var memo: [String: Int] = Dictionary()
        var result = 0

        for line in data {
            let ids = line.split(separator: " ").map(String.init)
            let name = String.init(ids[0].prefix(3))

            outs[name] = []
            for i in 1..<ids.count {
                outs[name]?.append(ids[i])
            }
        }

        result += traverse(name: "you", outs: outs, memo: &memo)
        return result
    }

    static func second(data: [String]) -> Int { return 0 }

    static func traverse(
        name: String,
        outs: [String: [String]],
        memo: inout [String: Int],
    ) -> Int {
        if name == "out" { return 1 }
        if let cached = memo[name] { return cached }

        var result = 0
        for out in outs[name] ?? [] {
            let paths = traverse(name: out, outs: outs, memo: &memo)
            memo[out] = paths
            result += paths
        }

        return result
    }

}
