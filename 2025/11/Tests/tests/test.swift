import Testing

@testable import app

let data: [String] = [
    "aaa: you hhh",
    "you: bbb ccc",
    "bbb: ddd eee",
    "ccc: ddd eee fff",
    "ddd: ggg",
    "eee: out",
    "fff: out",
    "ggg: out",
    "hhh: ccc fff iii",
    "iii: out",
]

@Test
func testFirst() throws {
    let firstExpected = 5
    let firstActual = app.lib.first(data: data)
    #expect(firstExpected == firstActual, "")
}

@Test
func testSecond() throws {
    let secondExpected = 0
    let secondActual = app.lib.second(data: data)
    #expect(secondExpected == secondActual, "")
}
