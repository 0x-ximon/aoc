struct Node: Hashable {
    let id: String
    let dac: Bool
    let fft: Bool
}

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

        func traverse(
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

        result += traverse(name: "you", outs: outs, memo: &memo)
        return result
    }

    static func second(data: [String]) -> Int {
        var paths: [String: [String]] = Dictionary()
        var memo: [Node: Int] = Dictionary()
        var result = 0

        for line in data {
            let outs = line.split(separator: " ").map(String.init)
            let id = String.init(outs[0].prefix(3))

            paths[id] = []
            for i in 1..<outs.count {
                paths[id]?.append(outs[i])
            }
        }

        func explore(id: String, dac: Bool, fft: Bool) -> Int {
            var result = 0
            var dac = dac
            var fft = fft

            if id == "dac" { dac = true }
            if id == "fft" { fft = true }
            if id == "out" { return dac && fft ? 1 : 0 }

            let key = Node(id: id, dac: dac, fft: fft)
            if let cached = memo[key] {
                return cached
            }

            for path in paths[id] ?? [] {
                result += explore(id: path, dac: dac, fft: fft)
            }

            memo[key] = result
            return result
        }

        result = explore(id: "svr", dac: false, fft: false)
        return result
    }
}
