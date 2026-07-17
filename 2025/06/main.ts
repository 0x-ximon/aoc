import fs from "node:fs";
import { first, second } from "./lib.ts";

function main() {
    const file = fs.readFileSync("input.txt", "utf-8");
    const data = file
        .split("\n")
        .map((line) => line.trimEnd())
        .filter((line) => line.length > 0);

    const firstAnswer = first(data.slice());
    console.info(`First Answer: ${firstAnswer}`);

    const secondAnswer = second(data.slice());
    console.info(`Second Answer: ${secondAnswer}`);
}

main();
