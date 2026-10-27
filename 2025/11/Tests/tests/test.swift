import Testing

@testable import app

@Test
func testFirst() throws {
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

    let firstExpected = 5
    let firstActual = app.lib.first(data: data)
    #expect(firstExpected == firstActual)
}

@Test
func testSecond() throws {
    let data = [
        "svr: aaa bbb",
        "aaa: fft",
        "fft: ccc",
        "bbb: tty",
        "tty: ccc",
        "ccc: ddd eee",
        "ddd: hub",
        "hub: fff",
        "eee: dac",
        "dac: fff",
        "fff: ggg hhh",
        "ggg: out",
        "hhh: out",
    ]

    let secondExpected = 2
    let secondActual = app.lib.second(data: data)
    #expect(secondExpected == secondActual)
}
