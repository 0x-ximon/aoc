import { first, second } from "./lib.ts";

function assert(expected: number, actual: number) {
    if (expected == actual) console.info("Assertion Passed.");
    else console.error(`Assertion Failed; expected: ${expected}, actual: ${actual}`);
}

function test_main() {
    const data: string[] = ["123 328  51 64 ", " 45 64  387 23 ", "  6 98  215 314", "*   +   *   +  "];

    const firstExpected = 4277556;
    const firstActual = first(data.slice());
    assert(firstExpected, firstActual);

    const secondExpected = 3263827;
    const secondActual = second(data.slice());
    assert(secondExpected, secondActual);
}

test_main();
