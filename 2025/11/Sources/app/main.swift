import Foundation

func main() {
    do {
        let file = try String(contentsOf: URL(fileURLWithPath: "input.txt"), encoding: .utf8)
        let data = file.split(separator: "\n").map(String.init)

        let firstAnswer = lib.first(data: data)
        print("First Answer: \(firstAnswer)")

        let secondAnswer = lib.second(data: data)
        print("Second Answer: \(secondAnswer)")
    } catch {
        print(error.localizedDescription)
    }
}

main()
